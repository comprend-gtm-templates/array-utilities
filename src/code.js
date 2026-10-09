const Object = require('Object');
const getType = require('getType');
const makeString = require('makeString');
const makeNumber = require('makeNumber');
const makeInteger = require('makeInteger');

// Guards the recursive copy against unexpectedly deep input.
const MAX_COPY_DEPTH = 20;

// The field keeps its original name, but it covers null and NaN as well.
const discardEmpty = !!data.discardUndefined;
const returnEmptyArray = !!data.returnEmptyArray;
// Variable instances saved before this field existed have no value for it, so
// only switch to first-value-wins when it is explicitly set to false.
const overwriteExisting = data.overwriteExisting !== false;

// Custom property values are the same for every object, so they are converted
// once here and only copied per object.
const customProps = data.addCustomProps ? readCustomProps(data.customPropMap) : [];

let output;
if (data.utilityMethod === 'objectArrayToArray') output = objectArrayToArray();
if (data.utilityMethod === 'objectArrayToObjectArray') output = objectArrayToObjectArray();
if (data.utilityMethod === 'multipleArraysToObjectArray') output = multipleArraysToObjectArray();

if (isArray(output) && output.length !== 0) return output;
// A new array every time, so an empty result is never a shared reference.
return returnEmptyArray ? [] : undefined;

/****************** UTILITY METHODS ******************/

function objectArrayToArray() {
  if (!isArray(data.sourceArray)) return [];

  const paths = [];
  forEachRow(data.fallbackPropMap, row => {
    const path = parsePath(row.sourceProp);
    if (path) paths.push(path);
  });
  // Variable instances saved before the table existed only carry the old
  // single property field, so it is still read when the table has no rows.
  if (paths.length === 0) {
    const legacyPath = parsePath(data.sourcePropName);
    if (legacyPath) paths.push(legacyPath);
  }
  if (paths.length === 0) return [];

  // Rows that resolve to undefined or to a discarded value are skipped, which
  // makes the rows below act as fallbacks. When several rows resolve to a
  // value, Overwrite Existing Values picks the last one (checked) or the first
  // one (unchecked), so the rows are read from the winning end.
  const lookupOrder = overwriteExisting ? paths.slice().reverse() : paths;

  const values = [];
  data.sourceArray.forEach(sourceObj => {
    const value = buildValue(readFirstValue(sourceObj, lookupOrder), data.convertArrValues);
    if (!isDiscarded(value)) values.push(value);
  });
  return values;
}

function objectArrayToObjectArray() {
  if (!isArray(data.sourceArray)) return [];

  const mappings = [];
  forEachRow(data.propMap, row => {
    const path = parsePath(row.sourceProp);
    const outputProp = toName(row.outputProp);
    if (!path || !outputProp) return;
    mappings.push({ path: path, outputProp: outputProp, convertTo: row.convertTo });
  });
  if (!data.keepAllProps && mappings.length === 0 && customProps.length === 0) return [];

  const objects = [];
  data.sourceArray.forEach(sourceObj => {
    if (!isObject(sourceObj)) return;
    const target = {};
    // Copied property by property so discarded values are left out here too.
    if (data.keepAllProps) {
      Object.keys(sourceObj).forEach(key => setProp(target, key, deepCopy(sourceObj[key], 1)));
    }
    mappings.forEach(mapping => {
      const value = buildValue(readPath(sourceObj, mapping.path), mapping.convertTo);
      setProp(target, mapping.outputProp, value);
    });
    objects.push(applyCustomProps(target));
  });
  return objects;
}

function multipleArraysToObjectArray() {
  const objects = [];
  forEachRow(data.multiArrayMap, row => {
    const outputProp = toName(row.outputProp);
    if (!outputProp || !isArray(row.sourceArray)) return;
    // Zipped by index: element i of every array lands in object i.
    row.sourceArray.forEach((sourceValue, i) => {
      if (!objects[i]) objects[i] = {};
      setProp(objects[i], outputProp, buildValue(sourceValue, row.convertTo));
    });
  });
  // Applied once per output object instead of once per array element.
  return objects.map(applyCustomProps);
}

/****************** HELPER FUNCTIONS ******************/

function isArray(value) {
  return getType(value) === 'array';
}

function isObject(value) {
  return getType(value) === 'object';
}

// A mapped variable or the Tests tab can deliver rows the UI would reject, so
// anything that is not a row object is skipped.
function forEachRow(rows, callback) {
  if (!isArray(rows)) return;
  rows.forEach(row => {
    if (isObject(row)) callback(row);
  });
}

// Trimmed so a stray space in a table cell cannot create a different key.
function toName(value) {
  if (value === undefined || value === null) return undefined;
  const name = makeString(value).trim();
  return name === '' ? undefined : name;
}

// Split once and reused for every source object.
function parsePath(value) {
  const path = toName(value);
  return path === undefined ? undefined : path.split('.');
}

function readPath(source, path) {
  return path.reduce((current, key) => {
    return isObject(current) || isArray(current) ? current[key] : undefined;
  }, source);
}

function readFirstValue(source, paths) {
  let value;
  paths.some(path => {
    value = readPath(source, path);
    return value !== undefined && !isDiscarded(value);
  });
  return value;
}

function readCustomProps(rows) {
  const props = [];
  forEachRow(rows, row => {
    const name = toName(row.propName);
    if (name) props.push({ name: name, value: convertValue(row.propValue, row.convertTo) });
  });
  return props;
}

function applyCustomProps(target) {
  customProps.forEach(prop => setProp(target, prop.name, deepCopy(prop.value, 0)));
  return target;
}

// Single entry point for anything written to the output: convert, then detach.
function buildValue(value, targetType) {
  return deepCopy(convertValue(value, targetType), 0);
}

function convertValue(value, targetType) {
  // Empty values stay as they are, so To String cannot turn null into "null"
  // and Discard Undefined Values still recognises them.
  if (isEmpty(value)) return value;
  if (targetType === 'string') return makeString(value);
  if (targetType === 'boolean') return toBoolean(value);
  if (targetType === 'number') return keepUnlessNaN(makeNumber(value), value);
  if (targetType === 'integer') return keepUnlessNaN(makeInteger(value), value);
  return value;
}

function toBoolean(value) {
  const text = makeString(value).trim().toLowerCase();
  if (text === 'true') return true;
  if (text === 'false' || text === '') return false;
  return !!value;
}

// NaN is the only value not equal to itself: keep the original value instead.
function keepUnlessNaN(converted, original) {
  return converted === converted ? converted : original;
}

// Undefined, null and NaN, the values Discard Undefined Values removes.
function isEmpty(value) {
  return value === undefined || value === null || value !== value;
}

// A discarded value is never written, so it cannot win over a later row.
function isDiscarded(value) {
  return discardEmpty && isEmpty(value);
}

function setProp(target, key, value) {
  if (isDiscarded(value)) return;
  // First value wins: never replace a property that already holds a value.
  if (!overwriteExisting && target[key] !== undefined) return;
  target[key] = value;
}

// Every value that reaches the output is copied, so the result shares no
// references with the source and can be changed freely downstream.
function deepCopy(value, depth) {
  if (depth > MAX_COPY_DEPTH) return undefined;
  if (isArray(value)) return value.map(item => deepCopy(item, depth + 1));
  if (!isObject(value)) return value;
  const copy = {};
  Object.keys(value).forEach(key => {
    copy[key] = deepCopy(value[key], depth + 1);
  });
  return copy;
}

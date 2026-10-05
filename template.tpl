___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Array Utilities",
  "categories": [
    "UTILITY"
  ],
  "description": "\u003cb\u003e-\u003c/b\u003e Array of Objects \u003e Array\u003cbr\u003e\n\u003cb\u003e-\u003c/b\u003e Array of Objects \u003e Array of Objects\u003cbr\u003e\n\u003cb\u003e-\u003c/b\u003e Multiple Arrays \u003e Array of Objects",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "utilityMethod",
    "displayName": "Utility Method",
    "simpleValueType": true,
    "defaultValue": "objectArrayToArray",
    "radioItems": [
      {
        "value": "objectArrayToArray",
        "displayValue": "Array of Objects \u003e Array of Values",
        "help": "Extracts one value from every object in the source array and returns the values as a flat array.\u003cbr\u003e\u003cbr\u003eList one or more properties in \u003cb\u003eSource Properties\u003c/b\u003e. The rows are read from top to bottom and rows that return undefined are skipped, so a property that is missing from an object falls back to the next row. When more than one row returns a value, \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e decides which one wins.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ prop1: \"value1\" }, { prop2: \"value2\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eSource Properties\u003c/b\u003e\u003cbr\u003eprop1\u003cbr\u003eprop2\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[ \"value1\", \"value2\" ]\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "value": "objectArrayToObjectArray",
        "displayValue": "Array of Objects \u003e Array of Objects",
        "help": "Picks the properties you choose from every object in the source array and builds a new array of objects.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ prop1: \"a\", prop2: \"b\" }, { prop1: \"c\", prop2: \"d\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eProperty Mapping\u003c/b\u003e\u003cbr\u003eprop2 \u0026rarr; new_prop\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[{ new_prop: \"b\" }, { new_prop: \"d\" }]\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "value": "multipleArraysToObjectArray",
        "displayValue": "Multiple Arrays \u003e Array of Objects",
        "help": "Combines several arrays into one array of objects. The arrays are zipped by position, so index 0 of every array becomes the first output object, index 1 the second, and so on.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eArray Mapping\u003c/b\u003e\u003cbr\u003e[ \"a\", \"b\" ] \u0026rarr; row1\u003cbr\u003e[ \"c\", \"d\" ] \u0026rarr; row2\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[{ row1: \"a\", row2: \"c\" }, { row1: \"b\", row2: \"d\" }]\u003c/li\u003e\u003c/ul\u003e"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "sourceArray",
    "displayName": "Source Array",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "valueHint": "{{DLV - ecommerce.items}}",
    "help": "The array to read from.\u003cbr\u003e\u003cbr\u003eReference a variable that returns a real array, for example {{DLV - ecommerce.items}}. A comma separated string will not work.\u003cbr\u003e\u003cbr\u003eIf the value is not an array, or the array is empty, the variable returns no output.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "utilityMethod",
        "paramValue": "multipleArraysToObjectArray",
        "type": "NOT_EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "OBJECT_ARRAY_TO_ARRAY",
    "displayName": "Array of Objects \u003e Array of Values",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "fallbackPropMap",
        "displayName": "Source Properties",
        "newRowButtonText": "Add Property",
        "alwaysInSummary": true,
        "help": "The properties to read from every object in the source array.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eHow the fallback works\u003c/b\u003e\u003cbr\u003eThe rows are read from top to bottom and rows that return undefined are skipped. Use a single row to read one property, or add more rows as fallbacks for the objects where the property above is missing. When more than one row returns a value, \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e decides which row wins.\u003cbr\u003e\u003cbr\u003eEvery object is handled on its own, so one object can be served by the first row while the next one falls back to a later row.\u003cbr\u003e\u003cbr\u003eUse dots to walk into nested objects and numeric indexes to walk into nested arrays.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ id_new: \"a1\" }, { legacy: { id: \"b2\" } }, { other: \"x\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eSource Properties\u003c/b\u003e\u003cbr\u003eid_new\u003cbr\u003elegacy.id\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[ \"a1\", \"b2\" ]\u003c/li\u003e\u003c/ul\u003eThe third object has none of the properties, so its value is undefined and is handled by \u003cb\u003eDiscard Undefined Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Source Property Name/Path",
            "name": "sourceProp",
            "type": "TEXT",
            "isUnique": false,
            "valueHint": "prop / prop.nested_prop",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "convertArrValues",
        "displayName": "Convert Value",
        "macrosInSelect": false,
        "simpleValueType": true,
        "defaultValue": false,
        "alwaysInSummary": true,
        "help": "Optionally converts every value before it is written to the output.\u003cul\u003e\u003cli\u003e\u003cb\u003eTo Number\u003c/b\u003e / \u003cb\u003eTo Integer\u003c/b\u003e\u003cbr\u003eConverts numeric strings. To Integer truncates decimals. If a value cannot be converted the original value is kept.\u003c/li\u003e\u003cli\u003e\u003cb\u003eTo String\u003c/b\u003e\u003cbr\u003eConverts any value to its string representation.\u003c/li\u003e\u003cli\u003e\u003cb\u003eTo Boolean\u003c/b\u003e\u003cbr\u003eThe strings \"true\" and \"false\" in any casing become true and false, an empty value becomes false, anything else follows normal truthiness.\u003c/li\u003e\u003c/ul\u003e",
        "selectItems": [
          {
            "value": false,
            "displayValue": "Do Not Convert"
          },
          {
            "value": "number",
            "displayValue": "To Number"
          },
          {
            "value": "integer",
            "displayValue": "To Integer"
          },
          {
            "value": "string",
            "displayValue": "To String"
          },
          {
            "value": "boolean",
            "displayValue": "To Boolean"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "utilityMethod",
        "paramValue": "objectArrayToArray",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "OBJECT_ARRAY_TO_OBJECT_ARRAY",
    "displayName": "Array of Objects \u003e Array of Objects",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "keepAllProps",
        "checkboxText": "Keep All Source Properties",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Copies every property of the source object into the output object first, then applies the \u003cb\u003eProperty Mapping\u003c/b\u003e below.\u003cbr\u003e\u003cbr\u003eLeave unchecked to output only the properties you map.\u003cbr\u003e\u003cbr\u003eA mapped property replaces a copied property with the same \u003cb\u003eOutput Property Name\u003c/b\u003e, unless \u003cb\u003eOverwrite Existing Values\u003c/b\u003e is turned off under \u003cb\u003eAdditional Options\u003c/b\u003e."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "propMap",
        "displayName": "Property Mapping",
        "newRowButtonText": "Add Property",
        "alwaysInSummary": true,
        "help": "Each row reads one property from every source object and writes it to the output object.\u003cbr\u003e\u003cbr\u003eRows are applied from top to bottom, so the same \u003cb\u003eOutput Property Name\u003c/b\u003e can be used in several rows to build a fallback. Which row wins is controlled by \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.\u003cbr\u003e\u003cbr\u003eThe table can be left empty when \u003cb\u003eKeep All Source Properties\u003c/b\u003e or \u003cb\u003eAdd Custom Properties\u003c/b\u003e is used.",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Source Property Name/Path",
            "name": "sourceProp",
            "type": "TEXT",
            "valueHint": "prop / prop.nested_prop",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Output Property Name",
            "name": "outputProp",
            "type": "TEXT",
            "isUnique": false,
            "valueHint": "new_prop_name",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": false,
            "displayName": "Convert Value",
            "name": "convertTo",
            "type": "SELECT",
            "macrosInSelect": false,
            "selectItems": [
              {
                "value": false,
                "displayValue": "Do Not Convert"
              },
              {
                "value": "number",
                "displayValue": "To Number"
              },
              {
                "value": "integer",
                "displayValue": "To Integer"
              },
              {
                "value": "string",
                "displayValue": "To String"
              },
              {
                "value": "boolean",
                "displayValue": "To Boolean"
              }
            ]
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "utilityMethod",
        "paramValue": "objectArrayToObjectArray",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "MULTIPLE_ARRAYS_TO_OBJECT_ARRAY",
    "displayName": "Multiple Arrays \u003e Array of Objects",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "multiArrayMap",
        "displayName": "Array Mapping",
        "newRowButtonText": "Add Array",
        "alwaysInSummary": true,
        "help": "Each row takes one array and writes its elements to a property of the output objects. The arrays are zipped by index, so values at the same position end up in the same object.\u003cbr\u003e\u003cbr\u003eArrays of different lengths are allowed. The output gets as many objects as the longest array, and objects beyond the end of a shorter array simply do not get that property.\u003cbr\u003e\u003cbr\u003eThe same \u003cb\u003eOutput Property Name\u003c/b\u003e can be reused in several rows. Rows are applied from top to bottom and which value wins is controlled by \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Source Array",
            "name": "sourceArray",
            "type": "TEXT",
            "valueHint": "{{DLV - item_ids}}",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Output Property Name",
            "name": "outputProp",
            "type": "TEXT",
            "isUnique": false,
            "valueHint": "new_prop_name",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": false,
            "displayName": "Convert Value",
            "name": "convertTo",
            "type": "SELECT",
            "macrosInSelect": false,
            "selectItems": [
              {
                "value": false,
                "displayValue": "Do Not Convert"
              },
              {
                "value": "number",
                "displayValue": "To Number"
              },
              {
                "value": "integer",
                "displayValue": "To Integer"
              },
              {
                "value": "string",
                "displayValue": "To String"
              },
              {
                "value": "boolean",
                "displayValue": "To Boolean"
              }
            ]
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "utilityMethod",
        "paramValue": "multipleArraysToObjectArray",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "addCustomProps",
    "checkboxText": "Add Custom Properties",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Adds the same extra properties to every object in the output.\u003cbr\u003e\u003cbr\u003eCustom properties are applied after the mapping above. They replace a mapped property with the same name, unless \u003cb\u003eOverwrite Existing Values\u003c/b\u003e is turned off under \u003cb\u003eAdditional Options\u003c/b\u003e.",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "customPropMap",
        "displayName": "Custom Properties",
        "newRowButtonText": "Add Custom Property",
        "alwaysInSummary": true,
        "help": "Each row adds one property with the same value to every object in the output.\u003cbr\u003e\u003cbr\u003eValues are evaluated once and then copied into each object, so a referenced variable is resolved a single time.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Custom Property Name",
            "name": "propName",
            "type": "TEXT",
            "isUnique": false,
            "valueHint": "custom_prop_name",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Custom Property Value",
            "name": "propValue",
            "type": "TEXT",
            "valueHint": "static value or {{Variable}}",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": false,
            "displayName": "Convert Value",
            "name": "convertTo",
            "type": "SELECT",
            "macrosInSelect": false,
            "selectItems": [
              {
                "value": false,
                "displayValue": "Do Not Convert"
              },
              {
                "value": "number",
                "displayValue": "To Number"
              },
              {
                "value": "integer",
                "displayValue": "To Integer"
              },
              {
                "value": "string",
                "displayValue": "To String"
              },
              {
                "value": "boolean",
                "displayValue": "To Boolean"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "addCustomProps",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "utilityMethod",
        "paramValue": "objectArrayToArray",
        "type": "NOT_EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "ADDITIONAL_OPTIONS",
    "displayName": "Additional Options",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "discardUndefined",
        "checkboxText": "Discard Undefined Values",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Controls what happens when a source value is undefined, for example when a property is missing from an object.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eThe property or array element is left out of the output.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eIt is still written, with the value undefined.\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "type": "CHECKBOX",
        "name": "overwriteExisting",
        "checkboxText": "Overwrite Existing Values",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Controls what happens when a value is written to an output property that already has one, for example when several mapping rows use the same \u003cb\u003eOutput Property Name\u003c/b\u003e, or when several \u003cb\u003eSource Properties\u003c/b\u003e rows return a value for the same source object.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eThe last value written wins.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eThe first value written wins and is not replaced. A property whose value is undefined still counts as empty, so a later row can fill it in.\u003c/li\u003e\u003c/ul\u003e\u003cbr\u003eWhen unchecked, properties copied by \u003cb\u003eKeep All Source Properties\u003c/b\u003e are kept as they are, and \u003cb\u003eCustom Properties\u003c/b\u003e no longer replace a mapped value."
      },
      {
        "type": "CHECKBOX",
        "name": "returnEmptyArray",
        "checkboxText": "Return an Empty Array Instead of Undefined",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Controls what the variable returns when there is nothing to output - no usable source array, no mapping rows, or every value discarded.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eAn empty array.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eundefined.\u003c/li\u003e\u003c/ul\u003e"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const getType = require('getType');
const makeString = require('makeString');
const makeNumber = require('makeNumber');
const makeInteger = require('makeInteger');

const MAX_COPY_DEPTH = 20;

const isArray = (value) => getType(value) === 'array';
const isObject = (value) => getType(value) === 'object';

const discardUndefined = !!data.discardUndefined;
const returnEmptyArray = !!data.returnEmptyArray;
// Variable instances saved before this field existed have no value for it, so
// only switch to first-value-wins when it is explicitly set to false.
const overwriteExisting = data.overwriteExisting !== false;

// Deep copy every value that reaches the output, so the result shares no
// references with the source input and can be mutated freely downstream.
const deepCopy = (value, depth) => {
  const level = depth || 0;
  if (level > MAX_COPY_DEPTH)
    return undefined;

  if (isArray(value)) {
    const arrayCopy = [];
    for (let i = 0; i < value.length; i++) {
      arrayCopy.push(deepCopy(value[i], level + 1));
    }
    return arrayCopy;
  }

  if (isObject(value)) {
    const objectCopy = {};
    const keys = Object.keys(value);
    for (let i = 0; i < keys.length; i++) {
      objectCopy[keys[i]] = deepCopy(value[keys[i]], level + 1);
    }
    return objectCopy;
  }

  return value;
};

// Split a source path once and reuse the parts for every source object.
const parsePath = (path) => getType(path) === 'string' && path !== '' ? path.split('.') : [];

const readPath = (source, parts) => {
  let current = source;
  for (let i = 0; i < parts.length; i++) {
    if (!isObject(current) && !isArray(current))
      return undefined;
    current = current[parts[i]];
  }
  return current;
};

const convertValue = (value, targetType) => {
  if (!targetType)
    return value;

  if (targetType === 'string')
    return makeString(value);

  if (targetType === 'boolean') {
    const text = makeString(value).toLowerCase();
    if (text === 'true')
      return true;
    if (text === 'false' || text === '')
      return false;
    return !!value;
  }

  const num = targetType === 'integer' ? makeInteger(value) : makeNumber(value);
  // num !== num is only true for NaN: keep the original value instead.
  return num === num ? num : value;
};

// Single entry point for anything written to the output: convert, then detach.
const buildValue = (value, targetType) => deepCopy(convertValue(value, targetType));

const setProp = (target, key, value) => {
  if (value === undefined && discardUndefined)
    return;
  // First value wins: never replace a property that already holds a value.
  if (!overwriteExisting && target[key] !== undefined)
    return;
  target[key] = value;
};

// A new array every time, so an empty result is never a shared reference.
const emptyOutput = () => returnEmptyArray ? [] : undefined;

const finish = (output) => {
  output = discardUndefined ? output.filter(val => val != null) : output;
  return output.length === 0 ? emptyOutput() : output;
};

// Custom property values are constants, so build them once instead of per row.
const customProps = [];
if (data.addCustomProps && isArray(data.customPropMap)) {
  data.customPropMap.forEach(row => {
    if (!row || !row.propName)
      return;
    customProps.push({
      name: row.propName,
      value: buildValue(row.propValue, row.convertTo)
    });
  });
}

const applyCustomProps = (target) => {
  for (let i = 0; i < customProps.length; i++) {
    setProp(
      target,
      customProps[i].name,
      deepCopy(customProps[i].value)
      );
  }
  return target;
};

if (data.utilityMethod === 'objectArrayToArray') {
  if (!isArray(data.sourceArray) || data.sourceArray.length === 0)
    return emptyOutput();

  // Every row of the table is a candidate path. Rows that resolve to undefined
  // are skipped, which is what makes the rows below the first one act as
  // fallbacks, while Overwrite Existing Values picks the winner whenever more
  // than one row resolves to a value.
  const paths = [];
  if (isArray(data.fallbackPropMap)) {
    data.fallbackPropMap.forEach(row => {
      if (!row || !row.sourceProp)
        return;
      const rowParts = parsePath(row.sourceProp);
      if (rowParts.length !== 0)
        paths.push(rowParts);
    });
  }
  // Variable instances saved before the table existed only carry the old
  // single property field, so it is still read when the table has no rows.
  if (paths.length === 0) {
    const legacyParts = parsePath(data.sourcePropName);
    if (legacyParts.length !== 0)
      paths.push(legacyParts);
  }
  if (paths.length === 0)
    return emptyOutput();

  const readValue = (sourceObj) => {
    let result;
    for (let i = 0; i < paths.length; i++) {
      const value = readPath(sourceObj, paths[i]);
      if (value !== undefined) {
        // Overwrite Existing Values decides which row wins: keep the value of
        // the first row that returned one, or let every later row replace it.
        if (!overwriteExisting)
          return value;
        result = value;
      }
    }
    return result;
  };

  const output = [];
  data.sourceArray.forEach(sourceObj => {
    const value = readValue(sourceObj);
    if (value === undefined && discardUndefined)
      return;
    output.push(buildValue(value, data.convertArrValues));
  });
  return finish(output);
}

if (data.utilityMethod === 'objectArrayToObjectArray') {
  if (!isArray(data.sourceArray) || data.sourceArray.length === 0)
    return emptyOutput();

  const mappings = [];
  if (isArray(data.propMap)) {
    data.propMap.forEach(row => {
      if (!row || !row.sourceProp || !row.outputProp)
        return;
      mappings.push({
        parts: parsePath(row.sourceProp),
        outputProp: row.outputProp,
        convertTo: row.convertTo
      });
    });
  }
  if (!data.keepAllProps && mappings.length === 0 && customProps.length === 0)
    return emptyOutput();

  const output = [];
  data.sourceArray.forEach(sourceObj => {
    if (!isObject(sourceObj))
      return;
    const outputObject = data.keepAllProps ? deepCopy(sourceObj) : {};
    for (let i = 0; i < mappings.length; i++) {
      const mapping = mappings[i];
      setProp(
        outputObject,
        mapping.outputProp,
        buildValue(readPath(sourceObj, mapping.parts), mapping.convertTo)
        );
    }
    applyCustomProps(outputObject);
    output.push(outputObject);
  });
  return finish(output);
}

if (data.utilityMethod === 'multipleArraysToObjectArray') {
  if (!isArray(data.multiArrayMap) || data.multiArrayMap.length === 0)
    return emptyOutput();

  const output = [];
  data.multiArrayMap.forEach(row => {
    if (!row || !row.outputProp || !isArray(row.sourceArray)) return;
    row.sourceArray.forEach((sourceValue, i) => {
      let target = output[i];
      if (!target) {
        target = {};
        output[i] = target;
      }
      setProp(target, row.outputProp, buildValue(sourceValue, row.convertTo));
    });
  });
  // Applied once per output object instead of once per array element.
  for (let i = 0; i < output.length; i++) {
    applyCustomProps(output[i]);
  }
  return finish(output);
}

return emptyOutput();


___TESTS___

scenarios:
- name: Multiple arrays to object array
  code: |-
    const mockData = {
      "addCustomProps": true,
      "utilityMethod":"multipleArraysToObjectArray",
      "multiArrayMap":[
        {
          "sourceArray":[1,2,3,4],
          "outputProp":"prop1",
          "convertTo":false
        },
        {
          "sourceArray":[1,2,3,4],
          "outputProp":"prop2",
          "convertTo":false
        },
      ],
      "customPropMap":[
        {
          "propName":"customProp1",
          "propValue":"customValue1",
          "convertTo":false
        }
      ],
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: Object array to object array
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: true,
      addCustomProps: false,
      sourceArray: [
        {
          item_id: "406445101",
          item_id_full: "406445101102",
          item_group_id: "406445",
          item_color_id: "101",
          item_variant_id: "102",
          item_name: "J Indoor Court",
          item_variant: "35",
          item_color: "WHITE",
          item_brand: "SOC",
          item_category: "Bordtennis",
          item_category2: "Bordtennisskor",
          item_categories: "Bordtennis|Bordtennisskor",
          seller: "Stadium",
          affiliation: "Stadium",
          affiliate_shop: "Stadium SE",
          price: 399,
          quantity: 1,
          price_total: 399
        }
      ],
      propMap: [
        { sourceProp: "item_id_full", outputProp: "item_id", convertTo: false },
      ]
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: Object array to array - simple property
  code: |
    const mockData = {
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ prop1: 'value1' }, { prop1: 'value2' }],
      fallbackPropMap: [{ sourceProp: 'prop1' }],
      convertArrValues: false
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(['value1', 'value2']);
- name: Object array to array - nested path + number conversion
  code: |
    const mockData = {
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ item: { price: '10.5' } }, { item: { price: '20' } }],
      fallbackPropMap: [{ sourceProp: 'item.price' }],
      convertArrValues: 'number'
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([10.5, 20]);
- name: Object array to object array - map props only (keepAllProps off)
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: false,
      addCustomProps: false,
      sourceArray: [
        { id: 'a1', name: 'Shoe', drop_me: 'x' },
        { id: 'a2', name: 'Sock', drop_me: 'y' }
        ],
      propMap: [
        { sourceProp: 'id', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'name', outputProp: 'item_name', convertTo: false }
        ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([
      { item_id: 'a1', item_name: 'Shoe' },
      { item_id: 'a2', item_name: 'Sock' }
      ]);
- name: Object array to object array - keepAllProps keeps and overrides
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: true,
      addCustomProps: false,
      sourceArray: [{ id: 'a1', id_full: 'a1-101', name: 'Shoe' }],
      propMap: [{ sourceProp: 'id_full', outputProp: 'id', convertTo: false }]
    };

    const variableResult = runCode(mockData);

    // All source props are copied, and the mapped prop overwrites the original value.
    assertThat(variableResult).isEqualTo([{ id: 'a1-101', id_full: 'a1-101', name: 'Shoe' }]);
- name: Object array to object array - all Convert Value options
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: false,
      addCustomProps: false,
      sourceArray: [{ price: '19.9', qty: '3', id: 12345, active: 'false', nested: { flag: 'true' } }],
      propMap: [
        { sourceProp: 'price', outputProp: 'price', convertTo: 'number' },
        { sourceProp: 'qty', outputProp: 'quantity', convertTo: 'integer' },
        { sourceProp: 'id', outputProp: 'item_id', convertTo: 'string' },
        { sourceProp: 'active', outputProp: 'active', convertTo: 'boolean' },
        { sourceProp: 'nested.flag', outputProp: 'flag', convertTo: 'boolean' }
        ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([{ price: 19.9, quantity: 3, item_id: '12345', active: false, flag: true }]);
- name: Object array to object array - custom properties
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: false,
      addCustomProps: true,
      sourceArray: [{ id: 'a1' }, { id: 'a2' }],
      propMap: [{ sourceProp: 'id', outputProp: 'item_id', convertTo: false }],
      customPropMap: [
        { propName: 'affiliation', propValue: 'Stadium', convertTo: false },
        { propName: 'quantity', propValue: '1', convertTo: 'integer' }
        ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([
      { item_id: 'a1', affiliation: 'Stadium', quantity: 1 },
      { item_id: 'a2', affiliation: 'Stadium', quantity: 1 }
      ]);
- name: Multiple arrays to object array - conversion, no custom props
  code: |-
    const mockData = {
      utilityMethod: 'multipleArraysToObjectArray',
      addCustomProps: false,
      multiArrayMap: [
        { sourceArray: ['value1', 'value2'], outputProp: 'row1', convertTo: false },
        { sourceArray: ['1', '2'], outputProp: 'row2', convertTo: 'integer' }
        ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([
      { row1: 'value1', row2: 1 },
      { row1: 'value2', row2: 2 }
      ]);
- name: Multiple arrays to object array - uneven arrays + custom props
  code: |-
    const mockData = {
      utilityMethod: 'multipleArraysToObjectArray',
      addCustomProps: true,
      multiArrayMap: [
        { sourceArray: ['a', 'b', 'c'], outputProp: 'row1', convertTo: false },
        { sourceArray: ['x'], outputProp: 'row2', convertTo: false }
        ],
      customPropMap: [{ propName: 'source', propValue: 'gtm', convertTo: false }]
    };

    const variableResult = runCode(mockData);

    // The shorter array only fills the first object, custom props are added to all of them.
    assertThat(variableResult).isEqualTo([
      { row1: 'a', row2: 'x', source: 'gtm' },
      { row1: 'b', source: 'gtm' },
      { row1: 'c', source: 'gtm' }
      ]);
- name: Empty or missing source data returns undefined
  code: |
    // Every utility method should return undefined when there is nothing to work with.

    assertThat(runCode({ utilityMethod: 'objectArrayToArray', fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [], fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

    // A source array with no properties to read from is nothing to work with either.
    assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [{ prop1: 'value1' }], fallbackPropMap: [] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'objectArrayToObjectArray', sourceArray: [], propMap: [] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'multipleArraysToObjectArray', multiArrayMap: [] })).isEqualTo(undefined);
- name: Discard Undefined Values - on
  code: |
    // Array output: the second object has no id, so nothing is pushed for it.
    const arrayResult = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1' }, { other: 'y' }],
      fallbackPropMap: [{ sourceProp: 'id' }],
      convertArrValues: false,
      discardUndefined: true
    });
    assertThat(arrayResult).isEqualTo(['a1']);

    // Object output: a mapping that resolves to undefined does not create the key.
    const objectResult = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: false,
      discardUndefined: true,
      sourceArray: [{ id: 'a1' }, { id: 'a2' }],
      propMap: [
        { sourceProp: 'id', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'missing.path', outputProp: 'gone', convertTo: false }
      ]
    });
    assertThat(objectResult).isEqualTo([{ item_id: 'a1' }, { item_id: 'a2' }]);
- name: Discard Undefined Values - off
  code: |
    // With the option off the placeholder is kept, so positions stay aligned.
    const arrayResult = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1' }, { other: 'y' }],
      fallbackPropMap: [{ sourceProp: 'id' }],
      convertArrValues: false,
      discardUndefined: false
    });
    assertThat(arrayResult).isEqualTo(['a1', undefined]);

    const objectResult = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: false,
      discardUndefined: false,
      sourceArray: [{ id: 'a1' }],
      propMap: [
        { sourceProp: 'id', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'missing.path', outputProp: 'gone', convertTo: false }
      ]
    });
    assertThat(objectResult).isEqualTo([{ item_id: 'a1', gone: undefined }]);
- name: Output is deep copied - no shared references with the source
  code: |
    // Objects copied with keepAllProps must be fully detached from the source.
    const source = [{ id: 'a1', nested: { deep: 'original', list: [1, 2] } }];

    const objectResult = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      keepAllProps: true,
      addCustomProps: false,
      sourceArray: source,
      propMap: []
    });

    objectResult[0].id = 'mutated';
    objectResult[0].nested.deep = 'mutated';
    objectResult[0].nested.list.push(3);

    assertThat(source[0].id).isEqualTo('a1');
    assertThat(source[0].nested.deep).isEqualTo('original');
    assertThat(source[0].nested.list).isEqualTo([1, 2]);

    // Objects pulled out by path must be detached too.
    const source2 = [{ item: { price: 1 } }];
    const arrayResult = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: source2,
      fallbackPropMap: [{ sourceProp: 'item' }],
      convertArrValues: false
    });

    arrayResult[0].price = 99;
    assertThat(source2[0].item.price).isEqualTo(1);
- name: Object array to object array - fallback mapping to one output prop
  code: |-
    // Several source properties can feed the same output property.
    // Rows are applied top to bottom and, with discardUndefined on,
    // a row without a value does not overwrite an earlier one.
    const result = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [
        { id_new: 'a1' },
        { id_legacy: 'b2' },
        { id_new: 'c3', id_legacy: 'd4' }
        ],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id_new', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: false }
        ],
      discardUndefined: true
    });

    assertThat(result).isEqualTo([
      { item_id: 'a1' },
      { item_id: 'b2' },
      { item_id: 'd4' }
      ]);
- name: Overwrite Existing Values - off keeps the first value
  code: |-
    // With Overwrite Existing Values off the first value written to a property
    // is kept, so later rows only fill in what is still missing.
    const result = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [
        { id_new: 'a1', id_legacy: 'b1' },
        { id_legacy: 'b2' }
        ],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id_new', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: false }
        ],
      discardUndefined: true,
      overwriteExisting: false
    });

    assertThat(result).isEqualTo([
      { item_id: 'a1' },
      { item_id: 'b2' }
      ]);
- name: Overwrite Existing Values - custom props vs mapped values
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ price: 10 }],
      keepAllProps: false,
      propMap: [{ sourceProp: 'price', outputProp: 'value', convertTo: false }],
      addCustomProps: true,
      customPropMap: [
        { propName: 'value', propValue: 'custom', convertTo: false },
        { propName: 'currency', propValue: 'SEK', convertTo: false }
        ],
      discardUndefined: true
    };

    // Default: a custom property replaces the mapped value.
    mockData.overwriteExisting = true;
    assertThat(runCode(mockData)).isEqualTo([{ value: 'custom', currency: 'SEK' }]);

    // Off: the mapped value is kept and only new properties are added.
    mockData.overwriteExisting = false;
    assertThat(runCode(mockData)).isEqualTo([{ value: 10, currency: 'SEK' }]);
- name: Return an Empty Array Instead of Undefined
  code: |
    // No usable source array.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: 'prop1' }],
      convertArrValues: false,
      returnEmptyArray: true
    })).isEqualTo([]);

    // Source data exists but every value is discarded.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ other: 1 }, { other: 2 }],
      fallbackPropMap: [{ sourceProp: 'prop1' }],
      convertArrValues: false,
      discardUndefined: true,
      returnEmptyArray: true
    })).isEqualTo([]);

    // No properties to read from.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ prop1: 'value1' }],
      fallbackPropMap: [],
      convertArrValues: false,
      returnEmptyArray: true
    })).isEqualTo([]);

    // Nothing to map in the object array method.
    assertThat(runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ prop1: 'value1' }],
      keepAllProps: false,
      propMap: [],
      returnEmptyArray: true
    })).isEqualTo([]);

    // Unchecked, the variable still returns undefined.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: 'prop1' }],
      convertArrValues: false,
      returnEmptyArray: false
    })).isEqualTo(undefined);
- name: Overwrite Existing Values - off still fills an undefined property
  code: |-
    // Discard Undefined Values off: the first row writes undefined, which still
    // counts as empty, so a later row can fill the property in.
    const filled = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [
        { id_legacy: 'b1' }
        ],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id_new', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: false }
        ],
      discardUndefined: false,
      overwriteExisting: false
    });

    assertThat(filled).isEqualTo([
      { item_id: 'b1' }
      ]);

    // Overwrite Existing Values on: the last row wins even when its value is
    // undefined, so a value that was already found can be replaced.
    const wiped = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [
        { id_legacy: 'b1' }
        ],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'id_new', outputProp: 'item_id', convertTo: false }
        ],
      discardUndefined: false,
      overwriteExisting: true
    });

    assertThat(wiped).isEqualTo([
      { item_id: undefined }
      ]);
- name: Object array to array - property fallback
  code: |
    // Rows that resolve to undefined are skipped, so a missing property falls
    // through to the next row, per source object. When more than one row resolves
    // to a value, Overwrite Existing Values decides which one wins.
    const result = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [
        { sourceProp: 'id_new' },
        { sourceProp: 'nested.id_legacy' }
      ],
      sourceArray: [
        { id_new: 'a1' },
        { nested: { id_legacy: 'b2' } },
        { id_new: 'c3', nested: { id_legacy: 'd4' } },
        { other: 'x' }
      ],
      convertArrValues: false,
      discardUndefined: true
    });

    // Default: the last row that resolved to a value wins.
    assertThat(result).isEqualTo(['a1', 'b2', 'd4']);

    // Overwrite Existing Values off: the first row that resolved to a value wins.
    const firstWins = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [
        { sourceProp: 'id_new' },
        { sourceProp: 'nested.id_legacy' }
      ],
      sourceArray: [
        { id_new: 'a1' },
        { nested: { id_legacy: 'b2' } },
        { id_new: 'c3', nested: { id_legacy: 'd4' } },
        { other: 'x' }
      ],
      convertArrValues: false,
      discardUndefined: true,
      overwriteExisting: false
    });

    assertThat(firstWins).isEqualTo(['a1', 'b2', 'c3']);

    // A single row behaves like a plain property read.
    const single = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: 'id' }],
      sourceArray: [{ id: 'a1' }, { id: 'a2' }],
      convertArrValues: false,
      discardUndefined: true
    });

    assertThat(single).isEqualTo(['a1', 'a2']);

    // Convert Value is applied to whichever row won.
    const converted = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [
        { sourceProp: 'price' },
        { sourceProp: 'price_fallback' }
      ],
      sourceArray: [{ price_fallback: '19.9' }],
      convertArrValues: 'number',
      discardUndefined: true
    });

    assertThat(converted).isEqualTo([19.9]);

    // A value of null or an empty string is a real value, so no fallback happens.
    // With Overwrite Existing Values off that first value is also what is kept.
    const emptyValues = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: 'id' }, { sourceProp: 'id_legacy' }],
      sourceArray: [{ id: '', id_legacy: 'b1' }, { id: null, id_legacy: 'b2' }],
      convertArrValues: false,
      discardUndefined: false,
      overwriteExisting: false
    });

    assertThat(emptyValues).isEqualTo(['', null]);

    // Discard Undefined Values off keeps a placeholder when no row has a value.
    const kept = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: 'id_new' }, { sourceProp: 'id_legacy' }],
      sourceArray: [{ id_legacy: 'b1' }, { other: 'x' }],
      convertArrValues: false,
      discardUndefined: false
    });

    assertThat(kept).isEqualTo(['b1', undefined]);

    // Rows without a property name are skipped.
    const blankRows = runCode({
      utilityMethod: 'objectArrayToArray',
      fallbackPropMap: [{ sourceProp: '' }, { sourceProp: 'id' }],
      sourceArray: [{ id: 'a1' }],
      convertArrValues: false
    });

    assertThat(blankRows).isEqualTo(['a1']);
- name: Object array to array - legacy single property field
  code: |-
    // Variable instances saved before the table existed only carry the old
    // sourcePropName field. They keep working: the value is used as the single
    // property to read when the table has no rows.
    const legacy = runCode({
      utilityMethod: 'objectArrayToArray',
      sourcePropName: 'item.price',
      sourceArray: [{ item: { price: 10 } }, { item: { price: 20 } }],
      convertArrValues: false,
      discardUndefined: true
    });

    assertThat(legacy).isEqualTo([10, 20]);

    // The table wins whenever it has at least one usable row.
    const tableWins = runCode({
      utilityMethod: 'objectArrayToArray',
      sourcePropName: 'old_prop',
      fallbackPropMap: [{ sourceProp: 'new_prop' }],
      sourceArray: [{ old_prop: 'old', new_prop: 'new' }],
      convertArrValues: false,
      discardUndefined: true
    });

    assertThat(tableWins).isEqualTo(['new']);


___NOTES___

Created on 04/03/2026, 10:44:33

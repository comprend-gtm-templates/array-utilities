___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1.1,
  "securityGroups": [],
  "displayName": "Array Utilities",
  "categories": [
    "UTILITY"
  ],
  "description": "Extract, remap and merge arrays:\u003cbr\u003e\n\u003cul\u003e\n\u003cli\u003eArray of Objects → Array of Values\u003c/li\u003e\n\u003cli\u003eArray of Objects → Array of Objects\u003c/li\u003e\n\u003cli\u003eMultiple Arrays → Array of Objects\u003c/li\u003e\n\u003c/ul\u003e",
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
    "alwaysInSummary": true,
    "radioItems": [
      {
        "value": "objectArrayToArray",
        "displayValue": "Array of Objects → Array of Values",
        "help": "Extracts one value from every object in the source array and returns the values as a flat array.\u003cbr\u003e\u003cbr\u003eList one or more properties in \u003cb\u003eSource Properties\u003c/b\u003e. The rows are read from top to bottom and rows that return undefined are skipped, so a property that is missing from an object falls back to the next row. When more than one row returns a value, \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e decides which one wins.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ prop1: \"value1\" }, { prop2: \"value2\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eSource Properties\u003c/b\u003e\u003cbr\u003eprop1\u003cbr\u003eprop2\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[ \"value1\", \"value2\" ]\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "value": "objectArrayToObjectArray",
        "displayValue": "Array of Objects → Array of Objects",
        "help": "Picks the properties you choose from every object in the source array and builds a new array of objects.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ prop1: \"a\", prop2: \"b\" }, { prop1: \"c\", prop2: \"d\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eProperty Mapping\u003c/b\u003e\u003cbr\u003eprop2 \u0026rarr; new_prop\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[{ new_prop: \"b\" }, { new_prop: \"d\" }]\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "value": "multipleArraysToObjectArray",
        "displayValue": "Multiple Arrays → Array of Objects",
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
    "help": "The array to read from.\u003cbr\u003e\u003cbr\u003eReference a variable that returns a real array, for example {{DLV - ecommerce.items}}. Text, including a comma-separated list, is not split into an array.\u003cbr\u003e\u003cbr\u003eIf the value is not an array, or the array is empty, the variable returns undefined, or an empty array when \u003cb\u003eReturn an Empty Array Instead of Undefined\u003c/b\u003e is checked under \u003cb\u003eAdditional Options\u003c/b\u003e.",
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
    "name": "objectArrayToArrayGroup",
    "displayName": "Values to Extract",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "fallbackPropMap",
        "displayName": "Source Properties",
        "newRowButtonText": "Add Property",
        "alwaysInSummary": true,
        "help": "The properties to read from every object in the source array.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eHow the fallback works\u003c/b\u003e\u003cbr\u003eThe rows are read from top to bottom and rows that return undefined are skipped, as are rows that return null or NaN while \u003cb\u003eDiscard Undefined, Null and NaN Values\u003c/b\u003e is checked. Use a single row to read one property, or add more rows as fallbacks for the objects where the property above is missing. When more than one row returns a value, \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e decides which row wins: the last one when checked (the default), the first one when unchecked.\u003cbr\u003e\u003cbr\u003eEvery object is handled on its own, so one object can be served by the first row while the next one falls back to a later row.\u003cbr\u003e\u003cbr\u003eUse dots to walk into nested objects and numeric indexes to walk into nested arrays.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eExample\u003c/b\u003e\u003cul\u003e\u003cli\u003e\u003cb\u003eSource Array\u003c/b\u003e\u003cbr\u003e[{ id_new: \"a1\" }, { legacy: { id: \"b2\" } }, { other: \"x\" }]\u003c/li\u003e\u003cli\u003e\u003cb\u003eSource Properties\u003c/b\u003e\u003cbr\u003eid_new\u003cbr\u003elegacy.id\u003c/li\u003e\u003cli\u003e\u003cb\u003eOutput\u003c/b\u003e\u003cbr\u003e[ \"a1\", \"b2\" ]\u003c/li\u003e\u003c/ul\u003eThe third object has none of the properties, so its value is undefined and is handled by \u003cb\u003eDiscard Undefined, Null and NaN Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.",
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
        "help": "Optionally converts every value before it is written to the output. Undefined, null and NaN values are never converted.\u003cul\u003e\u003cli\u003e\u003cb\u003eTo Number\u003c/b\u003e / \u003cb\u003eTo Integer\u003c/b\u003e\u003cbr\u003eConverts numeric strings. To Integer truncates decimals. If a value cannot be converted the original value is kept.\u003c/li\u003e\u003cli\u003e\u003cb\u003eTo String\u003c/b\u003e\u003cbr\u003eConverts any other value to its string representation.\u003c/li\u003e\u003cli\u003e\u003cb\u003eTo Boolean\u003c/b\u003e\u003cbr\u003eThe strings \"true\" and \"false\" in any casing become true and false, an empty string becomes false, anything else follows normal truthiness.\u003c/li\u003e\u003c/ul\u003e",
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
    "name": "objectArrayToObjectArrayGroup",
    "displayName": "Output Objects",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "keepAllProps",
        "checkboxText": "Keep All Source Properties",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Copies every property of the source object into the output object first, then applies the \u003cb\u003eProperty Mapping\u003c/b\u003e below.\u003cbr\u003e\u003cbr\u003eLeave unchecked to output only the properties you map.\u003cbr\u003e\u003cbr\u003eA mapped property replaces a copied property with the same \u003cb\u003eOutput Property Name\u003c/b\u003e, unless \u003cb\u003eOverwrite Existing Values\u003c/b\u003e is turned off under \u003cb\u003eAdditional Options\u003c/b\u003e. The source property itself is not removed, so mapping id_full to id keeps id_full in the output."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "propMap",
        "displayName": "Property Mapping",
        "newRowButtonText": "Add Property",
        "alwaysInSummary": true,
        "help": "Each row reads one property from every source object and writes it to the output object. Use dots to walk into nested objects.\u003cbr\u003e\u003cbr\u003eRows are applied from top to bottom, so the same \u003cb\u003eOutput Property Name\u003c/b\u003e can be used in several rows to build a fallback. Which row wins is controlled by \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eConvert Value\u003c/b\u003e changes the type of the value: To Number, To Integer (decimals truncated), To String or To Boolean (\"true\" and \"false\" in any casing). A value that cannot be converted to a number is kept as it is, and undefined, null and NaN values are never converted.\u003cbr\u003e\u003cbr\u003eThe table can be left empty when \u003cb\u003eKeep All Source Properties\u003c/b\u003e or \u003cb\u003eAdd Custom Properties\u003c/b\u003e is used. Entries in the source array that are not objects are skipped.",
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
    "name": "multipleArraysToObjectArrayGroup",
    "displayName": "Arrays to Combine",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "multiArrayMap",
        "displayName": "Array Mapping",
        "newRowButtonText": "Add Array",
        "alwaysInSummary": true,
        "help": "Each row takes one array and writes its elements to a property of the output objects. The arrays are zipped by index, so values at the same position end up in the same object.\u003cbr\u003e\u003cbr\u003eArrays of different lengths are allowed. The output gets as many objects as the longest array, and objects beyond the end of a shorter array simply do not get that property. A row whose \u003cb\u003eSource Array\u003c/b\u003e is not an array is skipped.\u003cbr\u003e\u003cbr\u003eThe same \u003cb\u003eOutput Property Name\u003c/b\u003e can be reused in several rows. Rows are applied from top to bottom and which value wins is controlled by \u003cb\u003eOverwrite Existing Values\u003c/b\u003e under \u003cb\u003eAdditional Options\u003c/b\u003e.\u003cbr\u003e\u003cbr\u003e\u003cb\u003eConvert Value\u003c/b\u003e changes the type of each element: To Number, To Integer (decimals truncated), To String or To Boolean (\"true\" and \"false\" in any casing). A value that cannot be converted to a number is kept as it is, and undefined, null and NaN values are never converted.",
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
        "help": "Each row adds one property with the same value to every object in the output.\u003cbr\u003e\u003cbr\u003eValues are evaluated and converted once and then copied into each object, so a referenced variable is resolved a single time. \u003cb\u003eConvert Value\u003c/b\u003e works as in the mapping table above.",
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
    "name": "additionalOptionsGroup",
    "displayName": "Additional Options",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "discardUndefined",
        "checkboxText": "Discard Undefined, Null and NaN Values",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Controls what happens when a value is undefined (for example a property that is missing from an object), null or NaN. Empty strings and zero are real values and are always kept.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eThe property or array element is left out of the output, including properties copied by \u003cb\u003eKeep All Source Properties\u003c/b\u003e and \u003cb\u003eCustom Properties\u003c/b\u003e. A discarded value never wins over another row, so a fallback row can still fill the property in.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eThe value is written as it is.\u003c/li\u003e\u003c/ul\u003e"
      },
      {
        "type": "CHECKBOX",
        "name": "overwriteExisting",
        "checkboxText": "Overwrite Existing Values",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Controls what happens when a value is written to an output property that already has one, for example when several mapping rows use the same \u003cb\u003eOutput Property Name\u003c/b\u003e, or when several \u003cb\u003eSource Properties\u003c/b\u003e rows return a value for the same source object.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eThe last value written wins.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eThe first value written wins and is not replaced. A property whose value is undefined still counts as empty, so a later row can fill it in.\u003c/li\u003e\u003c/ul\u003eWhen unchecked, properties copied by \u003cb\u003eKeep All Source Properties\u003c/b\u003e are kept as they are, and \u003cb\u003eCustom Properties\u003c/b\u003e no longer replace a mapped value."
      },
      {
        "type": "CHECKBOX",
        "name": "returnEmptyArray",
        "checkboxText": "Return an Empty Array Instead of Undefined",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Controls what the variable returns when there is nothing to output: no usable source array, no mapping rows, or every value discarded.\u003cul\u003e\u003cli\u003e\u003cb\u003eChecked\u003c/b\u003e\u003cbr\u003eAn empty array.\u003c/li\u003e\u003cli\u003e\u003cb\u003eUnchecked\u003c/b\u003e\u003cbr\u003eundefined.\u003c/li\u003e\u003c/ul\u003e"
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

const utilities = {
  'objectArrayToArray':          objectArrayToArray,
  'objectArrayToObjectArray':    objectArrayToObjectArray,
  'multipleArraysToObjectArray': multipleArraysToObjectArray
};

const utilityMethod = utilities[data.utilityMethod] || () => undefined;
const output = utilityMethod();

if (isArray(output) && output.length !== 0)
  return output;

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
  if (targetType === 'integer') return toInteger(value);
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

// makeInteger turns non-numeric text into 0 and rounds decimals, so the value
// is checked as a number first and truncated towards zero instead.
function toInteger(value) {
  const number = makeNumber(value);
  if (number !== number) return value;
  return makeInteger(number - number % 1);
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


___TESTS___

scenarios:
- name: 1 - Multiple arrays to object array
  code: |-
    const mockData = {
      addCustomProps: true,
      utilityMethod: 'multipleArraysToObjectArray',
      multiArrayMap: [
        { sourceArray: [1, 2, 3, 4], outputProp: 'prop1', convertTo: false },
        { sourceArray: [1, 2, 3, 4], outputProp: 'prop2', convertTo: false }
      ],
      customPropMap: [
        { propName: 'customProp1', propValue: 'customValue1', convertTo: false }
      ]
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([
      { prop1: 1, prop2: 1, customProp1: 'customValue1' },
      { prop1: 2, prop2: 2, customProp1: 'customValue1' },
      { prop1: 3, prop2: 3, customProp1: 'customValue1' },
      { prop1: 4, prop2: 4, customProp1: 'customValue1' }
    ]);
- name: 2 - Object array to object array
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

    const variableResult = runCode(mockData);

    // Every source property is kept and item_id is replaced by item_id_full.
    assertThat(variableResult).hasLength(1);
    assertThat(variableResult[0].item_id).isEqualTo('406445101102');
    assertThat(variableResult[0].item_id_full).isEqualTo('406445101102');
    assertThat(variableResult[0].item_name).isEqualTo('J Indoor Court');
    assertThat(variableResult[0].price_total).isEqualTo(399);
- name: 3 - Object array to array - simple property
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ prop1: 'value1' }, { prop1: 'value2' }],
      fallbackPropMap: [{ sourceProp: 'prop1' }],
      convertArrValues: false
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(['value1', 'value2']);
- name: 4 - Object array to array - nested path + number conversion
  code: |-
    const mockData = {
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ item: { price: '10.5' } }, { item: { price: '20' } }],
      fallbackPropMap: [{ sourceProp: 'item.price' }],
      convertArrValues: 'number'
    };

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo([10.5, 20]);
- name: 5 - Object array to object array - map props only (keepAllProps off)
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
- name: 6 - Object array to object array - keepAllProps keeps and overrides
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
- name: 7 - Object array to object array - all Convert Value options
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
- name: 8 - Object array to object array - custom properties
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
- name: 9 - Multiple arrays to object array - conversion, no custom props
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
- name: 10 - Multiple arrays to object array - uneven arrays + custom props
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
- name: 11 - Empty or missing source data returns undefined
  code: |-
    // Every utility method should return undefined when there is nothing to work with.

    assertThat(runCode({ utilityMethod: 'objectArrayToArray', fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [], fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

    // A source array with no properties to read from is nothing to work with either.
    assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [{ prop1: 'value1' }], fallbackPropMap: [] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'objectArrayToObjectArray', sourceArray: [], propMap: [] })).isEqualTo(undefined);

    assertThat(runCode({ utilityMethod: 'multipleArraysToObjectArray', multiArrayMap: [] })).isEqualTo(undefined);
- name: 12 - Discard Undefined Values - on
  code: |-
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
- name: 13 - Discard Undefined Values - off
  code: |-
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
- name: 14 - Output is deep copied - no shared references with the source
  code: |-
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
- name: 15 - Object array to object array - fallback mapping to one output prop
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
- name: 16 - Overwrite Existing Values - off keeps the first value
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
- name: 17 - Overwrite Existing Values - custom props vs mapped values
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
- name: 18 - Return an Empty Array Instead of Undefined
  code: |-
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
- name: 19 - Overwrite Existing Values - off still fills an undefined property
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
- name: 20 - Object array to array - property fallback
  code: |-
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

    // With Discard Undefined Values off, null and an empty string are real values,
    // so no fallback happens. With Overwrite Existing Values off that first value
    // is also what is kept.
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
- name: 21 - Object array to array - legacy single property field
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
- name: 22 - Convert Value leaves undefined values unconverted
  code: |-
    // A missing property must not become the text "undefined" or false, or it is
    // written even with Discard Undefined Values on.
    const discarded = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ id: 'a1' }],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'missing', outputProp: 'label', convertTo: 'string' },
        { sourceProp: 'missing', outputProp: 'flag', convertTo: 'boolean' }
      ],
      discardUndefined: true
    });

    assertThat(discarded).isEqualTo([{ item_id: 'a1' }]);

    // Discard Undefined Values off: the placeholder stays undefined.
    const kept = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 1 }, { other: 2 }],
      fallbackPropMap: [{ sourceProp: 'id' }],
      convertArrValues: 'string',
      discardUndefined: false
    });

    assertThat(kept).isEqualTo(['1', undefined]);
- name: 23 - Converted fallback rows still fall back when the first value is missing
  code: |-
    const result = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ id_legacy: 101 }, { id_new: 202, id_legacy: 303 }],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id_new', outputProp: 'item_id', convertTo: 'string' },
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: 'string' }
      ],
      discardUndefined: true,
      overwriteExisting: false
    });

    assertThat(result).isEqualTo([{ item_id: '101' }, { item_id: '202' }]);
- name: 24 - Spaces around property names in table cells are ignored
  code: |-
    const objects = runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ item: { id: 'a1' } }],
      keepAllProps: false,
      propMap: [{ sourceProp: ' item.id ', outputProp: ' item_id ', convertTo: false }],
      addCustomProps: true,
      customPropMap: [{ propName: ' source ', propValue: 'gtm', convertTo: false }]
    });

    assertThat(objects).isEqualTo([{ item_id: 'a1', source: 'gtm' }]);

    const values = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1' }],
      fallbackPropMap: [{ sourceProp: '  ' }, { sourceProp: ' id' }],
      convertArrValues: false
    });

    assertThat(values).isEqualTo(['a1']);
- name: 25 - Input that is not an array or not an object is skipped
  code: |-
    // A variable returning text instead of an array produces no output.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: 'a1,a2',
      fallbackPropMap: [{ sourceProp: 'id' }]
    })).isUndefined();

    // Entries that are not objects are left out of an array of objects.
    assertThat(runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ id: 'a1' }, 'a2', null, ['a3'], { id: 'a4' }],
      keepAllProps: false,
      propMap: [{ sourceProp: 'id', outputProp: 'item_id', convertTo: false }]
    })).isEqualTo([{ item_id: 'a1' }, { item_id: 'a4' }]);

    // A mapping row whose source is not an array is ignored.
    assertThat(runCode({
      utilityMethod: 'multipleArraysToObjectArray',
      multiArrayMap: [
        { sourceArray: 'not an array', outputProp: 'skipped', convertTo: false },
        { sourceArray: ['a', 'b'], outputProp: 'row1', convertTo: false }
      ]
    })).isEqualTo([{ row1: 'a' }, { row1: 'b' }]);

    // Rows that are not objects are ignored as well.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1' }],
      fallbackPropMap: [null, 'id', { sourceProp: 'id' }]
    })).isEqualTo(['a1']);
- name: 26 - Discard Undefined Values drops undefined, null and NaN in every method
  code: |-
    const notANumber = 0 / 0;

    // Empty strings and zero are real values and are kept.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1' }, { id: null }, { id: '' }, { id: notANumber }, { id: 0 }, { other: 'x' }],
      fallbackPropMap: [{ sourceProp: 'id' }],
      convertArrValues: false,
      discardUndefined: true
    })).isEqualTo(['a1', '', 0]);

    // Copied source properties, mapped properties and custom properties alike.
    assertThat(runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ id: 'a1', price: notANumber, discount: null, name: '' }],
      keepAllProps: true,
      propMap: [{ sourceProp: 'missing', outputProp: 'gone', convertTo: false }],
      addCustomProps: true,
      customPropMap: [{ propName: 'brand', propValue: null, convertTo: 'string' }],
      discardUndefined: true
    })).isEqualTo([{ id: 'a1', name: '' }]);

    // Objects stay in place so the positions still match the source arrays.
    assertThat(runCode({
      utilityMethod: 'multipleArraysToObjectArray',
      multiArrayMap: [{ sourceArray: ['a', null, notANumber], outputProp: 'row1', convertTo: false }],
      discardUndefined: true
    })).isEqualTo([{ row1: 'a' }, {}, {}]);
- name: 27 - To Boolean ignores case and surrounding spaces
  code: |-
    const result = runCode({
      utilityMethod: 'multipleArraysToObjectArray',
      multiArrayMap: [
        { sourceArray: [' FALSE ', 'True', '', 'yes', 0, 1], outputProp: 'flag', convertTo: 'boolean' }
      ]
    });

    assertThat(result).isEqualTo([
      { flag: false },
      { flag: true },
      { flag: false },
      { flag: true },
      { flag: false },
      { flag: true }
    ]);
- name: 28 - Number conversion keeps values that are not numeric
  code: |-
    const result = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ price: '19.90' }, { price: 'n/a' }, { price: 5 }],
      fallbackPropMap: [{ sourceProp: 'price' }],
      convertArrValues: 'number'
    });

    assertThat(result).isEqualTo([19.9, 'n/a', 5]);

    const integers = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ qty: '3.7' }, { qty: 'many' }],
      fallbackPropMap: [{ sourceProp: 'qty' }],
      convertArrValues: 'integer'
    });

    assertThat(integers).isEqualTo([3, 'many']);
- name: 29 - Unknown utility method returns nothing
  code: |-
    assertThat(runCode({
      utilityMethod: 'somethingElse',
      sourceArray: [{ id: 'a1' }],
      fallbackPropMap: [{ sourceProp: 'id' }]
    })).isUndefined();

    assertThat(runCode({
      utilityMethod: 'somethingElse',
      returnEmptyArray: true
    })).isEqualTo([]);
- name: 30 - Discard Undefined Values off keeps null and NaN unconverted
  code: |-
    const notANumber = 0 / 0;

    const result = runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: null }, { id: notANumber }, { id: 7 }],
      fallbackPropMap: [{ sourceProp: 'id' }],
      convertArrValues: 'string',
      discardUndefined: false
    });

    assertThat(result).hasLength(3);
    assertThat(result[0]).isNull();
    assertThat(result[1]).isNaN();
    assertThat(result[2]).isEqualTo('7');

    // The Tests tab runner dies when the last runCode output contains null or
    // NaN, so a final harmless call gives it something it can print.
    runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [{ id: 1 }], fallbackPropMap: [{ sourceProp: 'id' }] });
- name: 31 - Fallback rows skip discarded values
  code: |-
    const notANumber = 0 / 0;

    // Overwrite Existing Values off: a null in the first row does not block the second.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: null, id_legacy: 'b1' }],
      fallbackPropMap: [{ sourceProp: 'id' }, { sourceProp: 'id_legacy' }],
      convertArrValues: false,
      discardUndefined: true,
      overwriteExisting: false
    })).isEqualTo(['b1']);

    // Overwrite Existing Values on: a null in the last row does not replace the first.
    assertThat(runCode({
      utilityMethod: 'objectArrayToArray',
      sourceArray: [{ id: 'a1', id_legacy: null }],
      fallbackPropMap: [{ sourceProp: 'id' }, { sourceProp: 'id_legacy' }],
      convertArrValues: false,
      discardUndefined: true,
      overwriteExisting: true
    })).isEqualTo(['a1']);

    // The same holds for mapping rows that share an output property.
    assertThat(runCode({
      utilityMethod: 'objectArrayToObjectArray',
      sourceArray: [{ id: null, id_legacy: 'b1' }, { id: 'a2', id_legacy: notANumber }],
      keepAllProps: false,
      propMap: [
        { sourceProp: 'id', outputProp: 'item_id', convertTo: false },
        { sourceProp: 'id_legacy', outputProp: 'item_id', convertTo: false }
      ],
      discardUndefined: true,
      overwriteExisting: true
    })).isEqualTo([{ item_id: 'b1' }, { item_id: 'a2' }]);


___NOTES___

Created on 04/03/2026, 10:44:33

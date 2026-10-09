// Array Utilities: GTM custom variable template tests.
//
// Each block below is one test for the template editor's Tests tab. Add a
// test, name it exactly as the banner line (number included), and paste the
// code between that banner and the next one.
//
// This is a variable template that only reads its own fields, so no APIs are
// mocked: each test calls runCode(data) and asserts the returned value.

// ============================================================================
// 1 - Multiple arrays to object array
// ============================================================================
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

// ============================================================================
// 2 - Object array to object array
// ============================================================================
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

// ============================================================================
// 3 - Object array to array - simple property
// ============================================================================
const mockData = {
  utilityMethod: 'objectArrayToArray',
  sourceArray: [{ prop1: 'value1' }, { prop1: 'value2' }],
  fallbackPropMap: [{ sourceProp: 'prop1' }],
  convertArrValues: false
};

const variableResult = runCode(mockData);

assertThat(variableResult).isEqualTo(['value1', 'value2']);

// ============================================================================
// 4 - Object array to array - nested path + number conversion
// ============================================================================
const mockData = {
  utilityMethod: 'objectArrayToArray',
  sourceArray: [{ item: { price: '10.5' } }, { item: { price: '20' } }],
  fallbackPropMap: [{ sourceProp: 'item.price' }],
  convertArrValues: 'number'
};

const variableResult = runCode(mockData);

assertThat(variableResult).isEqualTo([10.5, 20]);

// ============================================================================
// 5 - Object array to object array - map props only (keepAllProps off)
// ============================================================================
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

// ============================================================================
// 6 - Object array to object array - keepAllProps keeps and overrides
// ============================================================================
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

// ============================================================================
// 7 - Object array to object array - all Convert Value options
// ============================================================================
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

// ============================================================================
// 8 - Object array to object array - custom properties
// ============================================================================
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

// ============================================================================
// 9 - Multiple arrays to object array - conversion, no custom props
// ============================================================================
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

// ============================================================================
// 10 - Multiple arrays to object array - uneven arrays + custom props
// ============================================================================
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

// ============================================================================
// 11 - Empty or missing source data returns undefined
// ============================================================================
// Every utility method should return undefined when there is nothing to work with.

assertThat(runCode({ utilityMethod: 'objectArrayToArray', fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [], fallbackPropMap: [{ sourceProp: 'prop1' }] })).isEqualTo(undefined);

// A source array with no properties to read from is nothing to work with either.
assertThat(runCode({ utilityMethod: 'objectArrayToArray', sourceArray: [{ prop1: 'value1' }], fallbackPropMap: [] })).isEqualTo(undefined);

assertThat(runCode({ utilityMethod: 'objectArrayToObjectArray', sourceArray: [], propMap: [] })).isEqualTo(undefined);

assertThat(runCode({ utilityMethod: 'multipleArraysToObjectArray', multiArrayMap: [] })).isEqualTo(undefined);

// ============================================================================
// 12 - Discard Undefined Values - on
// ============================================================================
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

// ============================================================================
// 13 - Discard Undefined Values - off
// ============================================================================
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

// ============================================================================
// 14 - Output is deep copied - no shared references with the source
// ============================================================================
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

// ============================================================================
// 15 - Object array to object array - fallback mapping to one output prop
// ============================================================================
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

// ============================================================================
// 16 - Overwrite Existing Values - off keeps the first value
// ============================================================================
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

// ============================================================================
// 17 - Overwrite Existing Values - custom props vs mapped values
// ============================================================================
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

// ============================================================================
// 18 - Return an Empty Array Instead of Undefined
// ============================================================================
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

// ============================================================================
// 19 - Overwrite Existing Values - off still fills an undefined property
// ============================================================================
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

// ============================================================================
// 20 - Object array to array - property fallback
// ============================================================================
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

// ============================================================================
// 21 - Object array to array - legacy single property field
// ============================================================================
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

// ============================================================================
// 22 - Convert Value leaves undefined values unconverted
// ============================================================================
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

// ============================================================================
// 23 - Converted fallback rows still fall back when the first value is missing
// ============================================================================
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

// ============================================================================
// 24 - Spaces around property names in table cells are ignored
// ============================================================================
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

// ============================================================================
// 25 - Input that is not an array or not an object is skipped
// ============================================================================
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

// ============================================================================
// 26 - Discard Undefined Values drops undefined, null and NaN in every method
// ============================================================================
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

// ============================================================================
// 27 - To Boolean ignores case and surrounding spaces
// ============================================================================
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

// ============================================================================
// 28 - Number conversion keeps values that are not numeric
// ============================================================================
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

// ============================================================================
// 29 - Unknown utility method returns nothing
// ============================================================================
assertThat(runCode({
  utilityMethod: 'somethingElse',
  sourceArray: [{ id: 'a1' }],
  fallbackPropMap: [{ sourceProp: 'id' }]
})).isUndefined();

assertThat(runCode({
  utilityMethod: 'somethingElse',
  returnEmptyArray: true
})).isEqualTo([]);

// ============================================================================
// 30 - Discard Undefined Values off keeps null and NaN unconverted
// ============================================================================
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

// ============================================================================
// 31 - Fallback rows skip discarded values
// ============================================================================
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

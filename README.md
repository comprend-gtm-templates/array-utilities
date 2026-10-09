# Array Utilities

## Purpose

A web container variable that reshapes arrays, typically the ecommerce `items` array from the data layer, into the shape another tag expects. It extracts one value from every object (for example a list of item IDs for a pixel), remaps an array of objects (rename, pick, convert or add properties), or zips several parallel arrays into one array of objects. It always returns a new array and never changes the source data.

## Behaviour

- **Array of Objects → Array of Values** reads the **Source Properties** from every object in **Source Array** and returns one value per object. Rows that return undefined are skipped, so a later row fills in for objects that lack an earlier property. When several rows return a value, the last row wins, or the first one when **Overwrite Existing Values** is unchecked.
- **Array of Objects → Array of Objects** builds one output object per source object from **Property Mapping**, optionally starting from a copy of all source properties. Entries in the source array that are not objects are skipped.
- **Multiple Arrays → Array of Objects** zips the arrays in **Array Mapping** by position: element 0 of every array goes into the first object, element 1 into the second, and so on. The output has as many objects as the longest array.
- **Custom Properties** are added to every output object after the mapping. Their values are resolved and converted once per evaluation.
- Property paths use dots for nested objects and numeric indexes for nested arrays (`item.price`, `variants.0.id`). Spaces around names in table cells are ignored.
- **Convert Value** runs before a value is written. Undefined, null and NaN values are never converted, and a value that cannot be converted to a number keeps its original value.
- With **Discard Undefined, Null and NaN Values** checked (the default), undefined, null and NaN never reach the output in any method, and a discarded value never wins over another row, so a fallback row can still fill the property in.
- Every value in the output is a copy, so changing the result elsewhere does not change the source.
- Returns undefined, or an empty array when **Return an Empty Array Instead of Undefined** is checked, when **Source Array** is not an array or is empty, when no usable mapping rows are configured, or when every value is discarded.

## Fields

### Method and source

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Utility Method | Yes | Array of Objects → Array of Values (default), Array of Objects → Array of Objects, Multiple Arrays → Array of Objects | Selects the transformation and which of the sections below is shown |
| Source Array | Yes, except for Multiple Arrays → Array of Objects | A variable that returns an array, usually of objects, for example `{{DLV - ecommerce.items}}`. Text, including a comma-separated list, is not split into an array | The array that is read. Not an array, or empty: no output |

### Values to Extract

Shown for **Array of Objects → Array of Values**.

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Source Properties | Yes | One **Source Property Name/Path** per row (`item_id`, `item.price`) | Read from every object, top to bottom. Rows that return undefined, or a value that is discarded, are skipped, so later rows act as fallbacks. **Overwrite Existing Values** picks the winner when several rows return a value |
| Convert Value | No | Do Not Convert (default), To Number, To Integer, To String, To Boolean | Converts every extracted value. To Integer truncates decimals. To Boolean turns `"true"` and `"false"` in any casing into booleans and an empty string into false |

### Output Objects

Shown for **Array of Objects → Array of Objects**.

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Keep All Source Properties | No | Checkbox, unchecked by default | Checked: every output object starts as a copy of its source object and the mapping is applied on top. A property mapped to a new name is kept under its old name as well |
| Property Mapping | No | Rows of **Source Property Name/Path**, **Output Property Name** and **Convert Value** | Each row writes one property to every output object. Several rows can share an **Output Property Name** to build a fallback. May be empty when **Keep All Source Properties** or **Add Custom Properties** is used; otherwise an empty table gives no output |

### Arrays to Combine

Shown for **Multiple Arrays → Array of Objects**.

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Array Mapping | Yes | Rows of **Source Array** (a variable returning an array), **Output Property Name** and **Convert Value** | Element n of each array becomes the **Output Property Name** property of output object n. A row whose source is not an array is skipped |

### Custom properties

Shown for the two methods that return objects.

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Add Custom Properties | No | Checkbox, unchecked by default | Shows **Custom Properties** |
| Custom Properties | When **Add Custom Properties** is checked | Rows of **Custom Property Name**, **Custom Property Value** (literal or variable) and **Convert Value** | Adds the same property to every output object after the mapping. Replaces a mapped property with the same name unless **Overwrite Existing Values** is unchecked |

### Additional Options

| Field | Required | Accepts | Effect on data |
| --- | --- | --- | --- |
| Discard Undefined, Null and NaN Values | No | Checkbox, checked by default | Checked: undefined, null and NaN are left out as properties (mapped, copied or custom) and as array elements. Empty strings and zero are kept. Unchecked: they are written as they are, which keeps an array of values aligned with the source |
| Overwrite Existing Values | No | Checkbox, checked by default | Checked: the last value written to a property wins, so custom properties replace mapped ones and mapped ones replace copied source properties. Unchecked: the first value wins and later rows only fill properties that are still undefined |
| Return an Empty Array Instead of Undefined | No | Checkbox, unchecked by default | Checked: returns `[]` when there is nothing to output. Unchecked: returns undefined |

### Output

| Utility Method | Returns |
| --- | --- |
| Array of Objects → Array of Values | An array of values, one per source object, minus discarded values |
| Array of Objects → Array of Objects | An array of objects, one per source entry that is an object |
| Multiple Arrays → Array of Objects | An array of objects, as many as the longest source array |

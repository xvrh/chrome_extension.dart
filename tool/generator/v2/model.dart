// Goal: create a new generator more suited for the following results:
//  - Inline some Dictionary in the method call if we detect their are never used
//    anywhere else.
//  - Detect generic classes
//  - Allow to export all necessary types from other file if necessary

// Approach:
//  - Create an intermediate model, matching the JavaScript binding but lowered
//    with top-level dictionaries, enums & typedef. Reference are unresolved
//     (just the raw name, except if they are synthetic)
//  - Create a second model with resolved references
//  - Create a visitor system to know whether a Dictionary is used as input or output or both.
//  - Separate the JS Type and the Dart Type, so at code generation
//  -

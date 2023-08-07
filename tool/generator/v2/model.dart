// # Goal: create a new generator more suited for the following results:
//  - Inline some Dictionary in the method call if we detect their are never used
//    anywhere else.
//  - Detect generic classes
//  - Allow to export all necessary types from other file if necessary

// # Approach:
//  - Create an intermediate model, matching the JavaScript binding but lowered
//    with top-level dictionaries, enums & typedef. Reference are unresolved
//     (just the raw name, except if they are synthetic)
//  - Handle type parameters at this step
//  - Create a second step to resolve the references
//  - Create a visitor system to know whether a Dictionary is used as input or output or both.
//  - Based on the simple common model, generate (at the same time?) both a JS
//     model and a Dart model.
//  - Correctly handle the Alias type
//  - Separate the JS Type and the Dart Type
//  - On both JS and Dart side, only register the Dictionaries to include only
//    when we emit a first reference to them.
//    Ideally, marking if it is used in "input" or "output" position.
//    Compute whether to inline some parameters in the Dart side.
//  - Emit the 2 generated models.
//  - Emit export directive if any used model are coming from an other file
//  - More test at each step (at least to compute the input/output types)

// # Result:
//  - A simpler API with inlined parameters
//  - Exported symbols
//  -

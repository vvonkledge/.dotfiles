;; JavaScript/TypeScript Tree-sitter queries for complexity-first highlighting

;; Async/await complexity
"async" @keyword.async
"await" @keyword.await

;; Promise chains (complex async patterns)
(call_expression
  function: (member_expression
    property: (property_identifier) @method.promise
    (#match? @method.promise "^(then|catch|finally)$")))

;; Callback functions (complexity indicator)
(arrow_function
  parameters: (formal_parameters) @parameter.callback) 

;; Try-catch blocks (error handling complexity)
(try_statement) @keyword.control.exception
"catch" @keyword.control.exception
"finally" @keyword.control.exception
"throw" @keyword.control.exception

;; Ternary operators (conditional complexity)
(ternary_expression) @operator.conditional.complex

;; Optional chaining (null safety complexity)
"?." @operator.optional_chain
"??" @operator.nullish_coalescing

;; Destructuring (complex pattern)
(object_pattern) @pattern.destructuring
(array_pattern) @pattern.destructuring

;; Spread operator (complexity)
"..." @operator.spread

;; Dynamic property access
(subscript_expression) @member.dynamic

;; Regular expressions (high complexity)
(regex) @string.regex.complex
;; Rust-specific Tree-sitter queries for complexity-first highlighting

;; Emphasize unsafe blocks and functions (high complexity/danger)
(unsafe_block) @keyword.control.unsafe
(function_item
  (function_modifiers
    "unsafe") @keyword.control.unsafe)

;; Highlight mutable references and bindings
(mutable_specifier) @type.qualifier.mut
(reference_type
  (mutable_specifier) @type.qualifier.mut)

;; Mark async/await as complex control flow
"async" @keyword.async
"await" @keyword.await

;; Emphasize error handling
"?" @operator.error_propagation
(try_expression) @keyword.control.exception

;; Highlight match arms (control flow complexity)
(match_expression) @keyword.control.conditional
(match_arm
  pattern: (_) @pattern.complex)

;; Mark recursive function calls
(call_expression
  function: (identifier) @function.recursive
  (#eq? @function.recursive "self"))

;; Highlight lifetime annotations (complexity indicator)
(lifetime) @type.lifetime.complex
(generic_type
  (lifetime) @type.lifetime.complex)
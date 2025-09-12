;; Python Tree-sitter queries for complexity-first highlighting

;; Async/await patterns
"async" @keyword.async
"await" @keyword.await

;; Exception handling (complexity)
(try_statement) @keyword.control.exception
(except_clause) @keyword.control.exception
(finally_clause) @keyword.control.exception
(raise_statement) @keyword.control.exception

;; Generator/yield (complex control flow)
"yield" @keyword.control.yield
(yield) @keyword.control.yield
(generator_expression) @expression.generator

;; List/dict/set comprehensions (complex expressions)
(list_comprehension) @expression.comprehension.complex
(dictionary_comprehension) @expression.comprehension.complex
(set_comprehension) @expression.comprehension.complex

;; Decorators (metaprogramming complexity)
(decorator) @attribute.decorator.complex

;; Lambda functions (inline complexity)
(lambda) @function.lambda.complex

;; Context managers (resource management complexity)
(with_statement) @keyword.control.context
"with" @keyword.control.context
"as" @keyword.control.context

;; Walrus operator (assignment expression complexity)
":=" @operator.walrus

;; Magic methods (special behavior)
(function_definition
  name: (identifier) @method.magic
  (#match? @method.magic "^__.*__$"))

;; Global/nonlocal (scope complexity)
"global" @keyword.scope.global
"nonlocal" @keyword.scope.nonlocal

;; Assert statements (debugging/validation)
(assert_statement) @keyword.control.assert
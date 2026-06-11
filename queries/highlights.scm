[
  "if"
  "elseif"
  "else"
  "endif"
  "while"
  "endwhile"
  "for"
  "in"
  "endfor"
  "try"
  "except"
  "finally"
  "endtry"
  "fork"
  "endfork"
  "return"
  "break"
  "continue"
] @keyword

[
  "pass"
] @function.builtin

(function_call
  function: (identifier) @function.call)

(function_call
  function: (system_object) @function.builtin)

(verb_call
  verb: (identifier) @function.method.call)

(property_access
  property: (identifier) @property)

(identifier) @variable
(system_object) @constant.builtin
(object_reference) @constant
(error_constant) @constant.builtin
(type_constant) @type.builtin
(integer) @number
(float) @number.float
(string) @string
(comment) @comment

[
  "="
  "+="
  "-="
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "^."
  "|."
  "&."
  "<<"
  ">>"
  "~"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "&&"
  "||"
  "!"
  "?"
  "|"
  "=>"
  "->"
  ".."
  "@"
] @operator

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  "."
  ":"
  ","
  ";"
] @punctuation.delimiter

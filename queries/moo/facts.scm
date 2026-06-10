(verb_call
  receiver: (_) @call.receiver
  verb: (_) @call.verb
  arguments: (_) @call.arguments) @call.verb_call

(function_call
  function: (_) @function.name
  arguments: (_) @function.arguments) @call.function

(object_reference) @ref.object
(system_object) @ref.system_object

(property_access
  receiver: (_) @property.receiver
  property: (_) @property.name) @property.access

(computed_property_access
  receiver: (_) @property.receiver
  property: (_) @property.computed) @property.computed_access

(assignment_statement
  left: (_) @assignment.left
  right: (_) @assignment.right) @assignment.statement

(assignment_expression
  left: (_) @assignment.left
  right: (_) @assignment.right) @assignment.expression

(comment) @comment

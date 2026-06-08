const PREC = {
  ASSIGN: 1,
  CONDITIONAL: 2,
  OR: 3,
  AND: 4,
  EQUALITY: 5,
  COMPARISON: 6,
  ADD: 7,
  MULTIPLY: 8,
  UNARY: 9,
  CALL: 10,
};

module.exports = grammar({
  name: 'moo',

  extras: $ => [
    /\s/,
  ],

  word: $ => $.identifier,

  conflicts: $ => [
    [$.scatter_pattern, $._expression],
    [$.argument_list, $.parenthesized_expression],
    [$.rest_scatter_element, $._expression],
  ],

  rules: {
    source_file: $ => repeat($._statement),

    _statement: $ => choice(
      $.empty_statement,
      $.assignment_statement,
      $.expression_statement,
      $.return_statement,
      $.if_statement,
      $.while_statement,
      $.for_statement,
      $.break_statement,
      $.continue_statement,
      $.try_statement,
      $.fork_statement
    ),

    empty_statement: _ => ';',

    assignment_statement: $ => prec(2, seq(
      field('left', $._assignment_target),
      choice('=', '+=', '-='),
      field('right', $._expression),
      ';'
    )),

    expression_statement: $ => prec(-1, seq($._expression, ';')),

    return_statement: $ => seq('return', optional($._expression), ';'),
    break_statement: _ => seq('break', ';'),
    continue_statement: _ => seq('continue', ';'),

    if_statement: $ => seq(
      'if',
      field('condition', $._expression),
      repeat($._statement),
      repeat($.elseif_clause),
      optional($.else_clause),
      'endif'
    ),

    elseif_clause: $ => seq(
      'elseif',
      field('condition', $._expression),
      repeat($._statement)
    ),

    else_clause: $ => seq(
      'else',
      repeat($._statement)
    ),

    while_statement: $ => seq(
      'while',
      field('condition', $._expression),
      repeat($._statement),
      'endwhile'
    ),

    for_statement: $ => seq(
      'for',
      choice(
        seq(field('value', $.identifier), 'in', field('collection', $._expression)),
        seq(field('value', $.identifier), ',', field('key', $.identifier), 'in', field('collection', $._expression))
      ),
      repeat($._statement),
      'endfor'
    ),

    try_statement: $ => seq(
      'try',
      repeat($._statement),
      repeat1($.except_clause),
      optional($.finally_clause),
      'endtry'
    ),

    except_clause: $ => prec(1, seq(
      'except',
      optional(field('variable', $.identifier)),
      optional(seq('(', optional(commaSep1($._expression)), ')')),
      optional(seq('=>', field('handler_value', $._expression))),
      repeat($._statement)
    )),

    finally_clause: $ => seq(
      'finally',
      repeat($._statement)
    ),

    fork_statement: $ => prec(1, seq(
      'fork',
      optional(field('name', $.identifier)),
      optional(seq('(', field('delay', $._expression), ')')),
      repeat($._statement),
      'endfork'
    )),

    _assignment_target: $ => choice(
      $.identifier,
      $.scatter_pattern,
      $.property_access,
      $.computed_property_access,
      $.index_expression,
      $.range_expression
    ),

    scatter_pattern: $ => seq(
      '{',
      optional(commaSep(choice(
        $.identifier,
        $.optional_scatter_element,
        $.rest_scatter_element
      ))),
      '}'
    ),

    optional_scatter_element: $ => seq(
      '?',
      field('name', $.identifier),
      optional(seq('=', field('default', $._expression)))
    ),

    rest_scatter_element: $ => seq('@', field('name', $.identifier)),

    _expression: $ => choice(
      $.assignment_expression,
      $.inline_error_expression,
      $.conditional_expression,
      $.binary_expression,
      $.unary_expression,
      $.verb_call,
      $.function_call,
      $.pass_call,
      $.property_access,
      $.computed_property_access,
      $.index_expression,
      $.range_expression,
      $.parenthesized_expression,
      $.splice_expression,
      $.range_literal,
      $.list_literal,
      $.map_literal,
      $.identifier,
      $.system_object,
      $.object_reference,
      $.error_constant,
      $.type_constant,
      $.integer,
      $.float,
      $.string,
      $.dollar
    ),

    parenthesized_expression: $ => seq('(', $._expression, ')'),

    assignment_expression: $ => prec.right(PREC.ASSIGN, seq(
      field('left', $._assignment_target),
      '=',
      field('right', $._expression)
    )),

    conditional_expression: $ => prec.right(PREC.CONDITIONAL, seq(
      field('condition', $._expression),
      '?',
      field('consequence', $._expression),
      '|',
      field('alternative', $._expression)
    )),

    binary_expression: $ => choice(
      ...[
        ['||', PREC.OR],
        ['&&', PREC.AND],
        ['==', PREC.EQUALITY],
        ['!=', PREC.EQUALITY],
        ['<', PREC.COMPARISON],
        ['<=', PREC.COMPARISON],
        ['>', PREC.COMPARISON],
        ['>=', PREC.COMPARISON],
        ['+', PREC.ADD],
        ['-', PREC.ADD],
        ['*', PREC.MULTIPLY],
        ['/', PREC.MULTIPLY],
        ['%', PREC.MULTIPLY],
      ].map(([operator, precedence]) => prec.left(precedence, seq(
        field('left', $._expression),
        field('operator', operator),
        field('right', $._expression)
      ))),
      prec.left(PREC.COMPARISON, seq(
        field('left', $._expression),
        field('operator', choice('in', seq('not', 'in'))),
        field('right', $._expression)
      ))
    ),

    unary_expression: $ => prec(PREC.UNARY, seq(
      field('operator', choice('!', '-', '+')),
      field('argument', $._expression)
    )),

    function_call: $ => prec(PREC.CALL, seq(
      field('function', choice($.identifier, $.system_object)),
      field('arguments', $.argument_list)
    )),

    pass_call: $ => prec(PREC.CALL, seq(
      'pass',
      field('arguments', $.argument_list)
    )),

    verb_call: $ => prec(PREC.CALL, seq(
      field('receiver', $._expression),
      ':',
      field('verb', choice($.identifier, seq('(', $._expression, ')'))),
      field('arguments', $.argument_list)
    )),

    property_access: $ => prec(PREC.CALL, seq(
      field('receiver', $._expression),
      '.',
      field('property', $.identifier)
    )),

    computed_property_access: $ => prec(PREC.CALL, seq(
      field('receiver', $._expression),
      '.',
      '(',
      field('property', $._expression),
      ')'
    )),

    index_expression: $ => prec(PREC.CALL, seq(
      field('collection', $._expression),
      '[',
      field('index', $._expression),
      ']'
    )),

    range_expression: $ => prec(PREC.CALL, seq(
      field('collection', $._expression),
      '[',
      field('start', optional($._expression)),
      '..',
      field('end', optional($._expression)),
      ']'
    )),

    argument_list: $ => seq(
      '(',
      optional(commaSep($._expression)),
      ')'
    ),

    splice_expression: $ => prec(PREC.UNARY, seq('@', $._expression)),

    list_literal: $ => seq(
      '{',
      optional(commaSep($._expression)),
      '}'
    ),

    map_literal: $ => seq(
      '[',
      optional(commaSep($.map_entry)),
      ']'
    ),

    range_literal: $ => seq(
      '[',
      field('start', optional($._expression)),
      '..',
      field('end', optional($._expression)),
      ']'
    ),

    map_entry: $ => seq(
      field('key', $._expression),
      '->',
      field('value', $._expression)
    ),

    inline_error_expression: $ => seq(
      '`',
      field('body', $._expression),
      '!',
      field('errors', commaSep1($._expression)),
      optional(seq('=>', field('fallback', $._expression))),
      '\''
    ),

    identifier: _ => /[A-Za-z_][A-Za-z0-9_]*/,
    system_object: _ => /\$[A-Za-z_][A-Za-z0-9_]*/,
    object_reference: _ => /#-?[0-9]+/,
    error_constant: _ => token(prec(1, /E_[A-Za-z0-9_]+/)),
    type_constant: _ => token(prec(1, choice('INT', 'FLOAT', 'STR', 'LIST', 'OBJ', 'ERR', 'NUM', 'MAP', 'WAIF', 'ANON', 'BOOL'))),
    dollar: _ => '$',
    integer: _ => /[0-9]+/,
    float: _ => /[0-9]+\.[0-9]+/,
    string: _ => token(seq('"', repeat(choice(/[^"\\]/, /\\./)), '"')),
  }
});

function commaSep(rule) {
  return seq(rule, repeat(seq(',', rule)), optional(','));
}

function commaSep1(rule) {
  return seq(rule, repeat(seq(',', rule)), optional(','));
}

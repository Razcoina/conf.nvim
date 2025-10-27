<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = new Finder()
  ->in(__DIR__)
;

return new Config()
  ->setRules([
    '@PhpCsFixer' => true,
    'no_alias_language_construct_call' => false,
    'no_mixed_echo_print' => ['use' => 'echo'],
    'braces_position' => [
      'classes_opening_brace' => 'next_line_unless_newline_at_signature_end',
      'functions_opening_brace' => 'next_line_unless_newline_at_signature_end',
      'control_structures_opening_brace' => 'same_line',
      'anonymous_functions_opening_brace' => 'same_line',
      'anonymous_classes_opening_brace' => 'same_line',
      'allow_single_line_anonymous_functions' => true,
      'allow_single_line_empty_anonymous_classes' => true,
    ],
    'numeric_literal_separator' => [
      'override_existing' => true,
      'strategy' => 'use_separator',
    ],
    'ordered_interfaces' => [
      'case_sensitive' => false,
      'direction' => 'ascend',
      'order' => 'alpha',
    ],
    'control_structure_continuation_position' => ['position' => 'same_line'],
    'declare_equal_normalize' => ['space' => 'single'],
    'assign_null_coalescing_to_coalesce_equal' => true,
    'new_expression_parentheses' => ['use_parentheses' => false],
    'ternary_to_null_coalescing' => true,
    'echo_tag_syntax' => [
      'format' => 'short',
      'shorten_simple_statements_only' => false,
    ],
    'type_declaration_spaces' => ['elements' => ['constant', 'function', 'property']],
  ])
  ->setFinder($finder)
  ->setIndent('  ')
  ->setLineEnding("\n")
;

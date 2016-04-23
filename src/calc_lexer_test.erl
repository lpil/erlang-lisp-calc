-module(calc_lexer_test).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

tokenizer_test_() ->
  [?_assertEqual(
      [{num, 123}],
      tokens("123")),
   ?_assertEqual(
      [{op, '+'}, {op, '-'}, {op, '*'}, {op, '/'}],
      tokens("+ - * /")),
   ?_assertEqual(
      [{'(', []}, {')', []}],
      tokens("()")),
   ?_assertEqual(
      [{'(', []}, {op, '+'}, {num, 1}, {num, 2}, {')', []}],
      tokens("(+ 1 2)"))
  ].

tokens(S) ->
  {ok, T, _} = calc_lexer:string(S),
  T.

-endif.

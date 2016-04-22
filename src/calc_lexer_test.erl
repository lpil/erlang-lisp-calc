-module(calc_lexer_test).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

tokenizer_test_() ->
  [?_assertEqual(
      [{number, 123}],
      tokens("123")),
   ?_assertEqual(
      [{op, '+'}, {op, '-'}, {op, '*'}, {op, '/'}],
      tokens("+ - * /"))].

tokens(S) ->
  {ok, T, _} = calc_lexer:string(S),
  T.

-endif.

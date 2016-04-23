-module(calc).
-export([evaluate/1]).

%% Public

evaluate(Code) ->
  {ok, Tokens, _} = calc_lexer:string(Code),
  {ok, Tree} = calc_parser:parse(Tokens),
  {ok, eval(Tree)}.

%% Private

eval([Fn|Args]) ->
  Vals = lists:map(fun eval/1, Args),
  apply_operator(Fn, Vals);
eval([]) -> 0;
eval(X)  -> X.


apply_operator('*', Args) ->
  Mult = fun(X, Y) -> X * Y end,
  lists:foldl(Mult, 1, Args);

apply_operator('/', [Arg]) ->
  1 / Arg;
apply_operator('/', [Hd|Tl]) ->
  Div = fun(X, Y) -> Y / X end,
  lists:foldl(Div, Hd, Tl);

apply_operator('+', [Hd|Tail]) ->
  Add = fun(X, Y) -> X + Y end,
  lists:foldl(Add, Hd, Tail);

apply_operator('-', [Arg]) ->
  0 - Arg;
apply_operator('-', [Hd|Tail]) ->
  Sub = fun(X, Y) -> Y - X end,
  lists:foldl(Sub, Hd, Tail).


-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

basic_types_test_() ->
  [?_assertEqual(
      {ok, 1},
      evaluate("1")),
   ?_assertEqual(
      {ok, 0},
      evaluate("()"))].

addition_test_() ->
  [?_assertEqual(
      {ok, 99},
      evaluate("(+ 99)")),
   ?_assertEqual(
      {ok, 15},
      evaluate("(+ 5 5 5)"))].

subtraction_test_() ->
  [?_assertEqual(
      {ok, -10},
      evaluate("(- 10 20)")),
   ?_assertEqual(
      {ok, -15},
      evaluate("(- 15)"))].

multiplication_test_() ->
  [?_assertEqual(
      {ok, 15},
      evaluate("(* 15)")),
   ?_assertEqual(
      {ok, 144},
      evaluate("(* 12 12 1)"))].

division_test_() ->
  [?_assertEqual(
      {ok, 0.1},
      evaluate("(/ 10)")),
   ?_assertEqual(
      {ok, 2.0},
      evaluate("(/ 20 5 2)"))].

nested_expression_test_() ->
  [?_assertEqual(
      {ok, 100},
      evaluate("(* 10 (+ 10 (- 5)) 2)"))].

-endif.

-module(calc).
-export([evaluate/1]).

%% Public

evaluate(Code) ->
  {ok, Tokens, _} = calc_lexer:string(Code),
  {ok, Tree} = calc_parser:parse(Tokens),
  {ok, eval(Tree)}.

%% Private

eval([Fn|Args]) ->
  eval_sexp(Fn, Args);
eval([]) -> 0;
eval(X)  -> X.


eval_sexp('*', Args) ->
  Mult = fun(X, Y) -> X * Y end,
  lists:foldl(Mult, 1, Args);

eval_sexp('/', [Arg]) ->
  1 / Arg;
eval_sexp('/', [Hd|Tl]) ->
  Div = fun(X, Y) -> Y / X end,
  lists:foldl(Div, Hd, Tl);

eval_sexp('+', [Hd|Tail]) ->
  Add = fun(X, Y) -> X + Y end,
  lists:foldl(Add, Hd, Tail);

eval_sexp('-', [Arg]) ->
  0 - Arg;
eval_sexp('-', [Hd|Tail]) ->
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

-endif.

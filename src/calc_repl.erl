-module(calc_repl).
-export([run/0]).

run() ->
  io:put_chars("Welcome to calc.\n"),
  loop().

loop() ->
  case io:get_line("calc> ") of
    "exit\n" ->
      io:put_chars("Goodbye.\n");

    Input ->
      {ok, Result} = calc:evaluate(Input),
      io:format("~p\n", [Result]),
      loop()
  end.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

repl_test_() ->
  [].

-endif.

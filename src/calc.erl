-module(calc).

-include_lib("eunit/include/eunit.hrl").

%% API exports
-export([hello/0]).

%%====================================================================
%% API functions
%%====================================================================

hello() ->
  "Hello, world!".


-ifdef(TEST).
eunit_test_() ->
  [?_assertEqual(2, 1 + 1),
   ?_assertEqual("hello", "hello")].
-endif.

%%====================================================================
%% Internal functions
%%====================================================================

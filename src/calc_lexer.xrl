Definitions.

Num   = [0-9]
WS    = [\n\s\r\t]
OP    = [/*+-]

Rules.

{Num}+   : {token, {num, int(TokenChars)}}.
{OP}     : {token, {op, list_to_atom(TokenChars)}}.
[(]      : {token, {'(', ""}}.
[)]      : {token, {')', ""}}.
{WS}     : skip_token.

Erlang code.

int(S) when is_list(S) ->
  {I, _} = string:to_integer(S),
  I.

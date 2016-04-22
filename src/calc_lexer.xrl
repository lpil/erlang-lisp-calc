Definitions.

Num   = [0-9]
WS    = [\n\s\r\t]
OP    = [/*+-]
Param = [()]

Rules.

{Num}+   : {token, {number, as_int(TokenChars)}}.
{OP}     : {token, {op, list_to_atom(TokenChars)}}.
{Param}  : {token, {param, list_to_atom(TokenChars)}}.
{WS}     : skip_token.

Erlang code.

as_int(S) when is_list(S) ->
  {I, _} = string:to_integer(S),
  I.

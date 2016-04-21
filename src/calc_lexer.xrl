Definitions.

Num = [0-9]
WS  = [\n\s\r\t]

Rules.

{Num}+   : {token, {number, as_int(TokenChars)}}.
{WS}     : skip_token.

Erlang code.

as_int(S) when is_list(S) ->
  {I, _} = string:to_integer(S),
  I.

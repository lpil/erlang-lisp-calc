Nonterminals expression elements element.

Terminals '(' ')' num op.

Rootsymbol expression.

expression -> '$empty'         : [].
expression -> num              : val('$1').
expression -> '(' ')'          : [].
expression -> '(' elements ')' : ['$2'].

elements -> element : ['$1'].
elements -> element elements : ['$1'|'$2'].

element -> num : '$1'.
element -> op  : '$1'.

Erlang code.

val({_, V}) -> V.

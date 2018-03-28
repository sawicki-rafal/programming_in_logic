leaves_expr([X], X).
leaves_expr(Leaves, X + Y) :-
    append([L|Left], [R|Right], Leaves),
    leaves_expr([L|Left], X),
    leaves_expr([R|Right], Y).
leaves_expr(Leaves, X * Y) :-
    append([L|Left], [R|Right], Leaves),
    leaves_expr([L|Left], X),
    leaves_expr([R|Right], Y).

leaves_expr(Leaves, X - Y) :-
    append([L|Left], [R|Right], Leaves),
    leaves_expr([L|Left], X),
    leaves_expr([R|Right], Y).

leaves_expr(Leaves, X / Y) :-
    append([L|Left], [R|Right], Leaves),
    leaves_expr([L|Left], X),
    leaves_expr([R|Right], Y).



expr_parenthesized(X) -->
    [X].
expr_parenthesized(X + Y) -->
    ['('],
    expr_parenthesized(X),
    [+],
    expr_parenthesized(Y),
    [')'].

expr_parenthesized(X - Y) -->
    ['('],
    expr_parenthesized(X),
    [-],
    expr_parenthesized(Y),
    [')'].

expr_parenthesized(X / Y) -->
    ['('],
    expr_parenthesized(X),
    [/],
    expr_parenthesized(Y),
    [')'].



expr_parenthesized(X * Y) -->
    ['('],
    expr_parenthesized(X),
    [*],
    expr_parenthesized(Y),
    [')'].




expr(Z) --> num(Z).
expr(Z) --> num(X), [+], expr(Y), {Z is X+Y}.
expr(Z) --> num(X), [-], expr(Y), {Z is X-Y}.
expr(Z) --> num(X), [*], expr(Y), {Z is X*Y}.
expr(Z) --> num(X), [/], expr(Y), {Y=\=0,Z is X/Y}.

expr(Z) --> ['('],expr(Y),[')'],[+],expr(X), {Z is X+Y}.
expr(Z) --> ['('],expr(Y),[')'],[-],expr(X), {Z is X-Y}.
expr(Z) --> ['('],expr(Y),[')'],[*],expr(X), {Z is X*Y}.
expr(Z) --> ['('],expr(Y),[')'],[/],expr(X), {X=\=0,Z is Y/X}.
expr(Z) --> ['('],expr(Y),[')'],{Z is Y}.


num(D) --> [D], {number(D)}.

expr_value(L, V) :- expr(V, L, []).

wyrazenie(L, V, Expr):-
    leaves_expr(L, Expr), expr_parenthesized(Expr, Parenthesized,[]),
    expr_value( Parenthesized,V).



on(a,b).
on(b,c).
on(c,d).

above(X,Y):-
    on(X,Y).

above(X,Y):-
    on(X,Z),
    above(Z,Y).

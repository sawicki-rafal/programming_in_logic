singly(X,L):-
    select(X,L,L2),
    \+ member(X,L2).

doubly(X,L):-
    select(X,L,L2),
    singly(X,L2).

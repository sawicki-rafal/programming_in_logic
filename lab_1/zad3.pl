left_of(pencil,hourglass):-!.
left_of(hourglass,butterfly):-!.
left_of(butterfly,fish):-!.

left_of(X,Y):-
    left_of(X,Z),
    left_of(Z,Y).

above(nothing,bicycle):-!.
above(bicycle,pencil):-!.
above(camera,butterly):-!.


right_of(X,Y):-
    left_of(Y,X).

below(X,Y):-
    above(Y,X).

higer(X,Y):-
    above(X,Y),!.

higher(X,Y):-
    above(X,Z),
    higher(Z,Y).

higher(X,Y):-
    above(X,Z),
    (   left_of(Z,Y);right_of(Z,Y)).

higher(X,Y):-
    above(X,A),
    above(Y,B),
    higher(A,B).



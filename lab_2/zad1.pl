middle([X],X).

middle([_|T],X):-
    withoutLast(T,TWithoutLast),
    middle(TWithoutLast,X).

withoutLast([_],[]).

withoutLast([H|T],[H|TailWithoutLast]):-
    withoutLast(T,TailWithoutLast).

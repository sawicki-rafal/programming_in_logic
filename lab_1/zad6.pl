divisible(X,Y):-
    N is Y*Y,
    N=<X,
    X mod Y =:=0,!.

divisible(X,Y):-
    Y < X,
    Y1 is Y+1,
    divisible(X,Y1).

isPrime(X):-
    (   X > 1, \+ divisible(X,2)).

prime(LO,HI,N):-
    between(LO,HI,N),
    isPrime(N).

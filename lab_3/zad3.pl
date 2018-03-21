evenPermutation(X,Y):-
    permutation(X,Y),
    sign(X,Xs),
    sign(Y,Ys),
    Xs=Ys.

oddPermutation(X,Y):-
    permutation(X,Y),
    sign(X,Xs),
    sign(Y,Ys),
    Xs=\=Ys.


sign(L,S):-
    sign(L,-1,S).

sign([],N,S):-
    (0 is mod(N,2) -> S is -1; S is 1).

sign([H|T],N,S):-
    amountOfGreaterNumbers(T,H,N1),
    N2 is N+N1,
    sign(T,N2,S).

amountOfGreaterNumbers(L,X,N):-
    amountOfGreaterNumbers(L,X,0,N).

amountOfGreaterNumbers([],_,N,N).

amountOfGreaterNumbers([H|T],X,Acc,N):-
    (H>X->Acc1 is Acc+1; Acc1 is Acc),
    amountOfGreaterNumbers(T,X,Acc1,N).

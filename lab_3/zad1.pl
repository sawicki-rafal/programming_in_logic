variance(L,D):-
    sumlist(L,S),
    length(L,N),
    M is S/N,
    variance(L,M,N,D).

variance([],_,_,0).
variance([H|T],M,N,D):-
    variance(T,M,N,D1),
    D is (D1 + ((H-M)*(H-M))/N).




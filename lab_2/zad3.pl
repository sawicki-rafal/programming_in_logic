arc(a,b).
arc(b,a).
arc(b,c).
arc(c,d).


reachable(X,Y):-
        setof(Y,canReach(X,Y),K),
        member(Y,K).

canReach(X,Y):-
        isReachable(X,Y,[]).

isReachable(X,X,VISITED):-
        (\+ member(X,VISITED)).

isReachable(X,Y,VISITED):-
    (   \+ member(X,VISITED)),
    arc(X,Y).


isReachable(X,Y,VISITED):-
   (\+ member(X,VISITED)),
   arc(X,Z),
    isReachable(Z,Y,[X|VISITED]).

maxSum(L,S):-
    maxSum(L,0,0,S).

maxSum([],MaxSoFar,_,MaxSoFar).
maxSum([H|T],MaxSoFar,CurrentMax,S):-
    NewCurrentMax is max(0,CurrentMax+H),
    NewMaxSoFar is max(MaxSoFar,NewCurrentMax),
    maxSum(T,NewMaxSoFar,NewCurrentMax,S).

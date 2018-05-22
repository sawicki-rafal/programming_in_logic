size(8).

queens(N, P) :-
	numlist(1, N, L),
	permutation(L, P),
	\+ bad(P).

bad(P) :-
	append(_, [I | L1], P),
	append(L2, [J | _], L1),
	length(L2, K),
	abs(I-J) =:= K+1.

row(N,ROW):-
	size(SIZE),
	row(N,1,[],ROW,SIZE).

row(_,CURRENT,ROWOUT,ROWOUT,SIZE):-
	CURRENT>SIZE,!.

row(N,CURRENT,ROWIN,ROWOUT,SIZE):-
	(   (N==CURRENT)
	->  append(ROWIN,[x],ROWIN2)
	;   append(ROWIN,[y],ROWIN2)),
	NEWCURRENT is CURRENT + 1,
	row(N,NEWCURRENT,ROWIN2,ROWOUT,SIZE).

singly(X,L):-
    select(X,L,L2),
    \+ member(X,L2).

doubly(X,L):-
    select(X,L,L2),
    singly(X,L2).

list(N,X):-
        Length is 2*N,
    length(X,Length),
    between(1,N,NumberToCheck),
    doubly(NumberToCheck,X).



lista(Nmax, X) :-
	addElements(2, Nmax, [1,2], [1], X).

%addElements(N, Nmax, Acc, X)
%N - current highest number that can be added to the list
%AvailableNumbers - numbers that can be currently added to the list
%Nmax - highest number in the list
%Acc - accumulator for the answer
%X - possible solution

% case when we add a number for the second time
addElements(N, Nmax, AvailableNumbers, Acc, X) :-
	N =< Nmax,
	select(NewElement, AvailableNumbers, AvailableNumbers2),
	indexDifferenceIsOdd(Acc, NewElement),
	append(Acc, [NewElement], Acc2),
	addElements(N, Nmax, AvailableNumbers2,	Acc2, X).

% case when we add a number that is not part of our solution - new
% highest but it's LE than Nmax
addElements(N, Nmax, AvailableNumbers, Acc, X) :-
	N < Nmax,
	\+ member(N, Acc),
	N2 is N + 1,
	append(Acc, [N], Acc2),
	addElements(N2, Nmax, [ N2 | AvailableNumbers], Acc2, X).

%case when we add Nmax for the first time
addElements(Nmax, Nmax, AvailableNumbers, Acc, X) :-
	\+ member(Nmax, Acc),
	append(Acc, [Nmax], Acc2),
	addElements(Nmax, Nmax, AvailableNumbers, Acc2, X).

addElements(_, _, [], Acc, Acc).

indexDifferenceIsOdd(Acc, NewElement) :-
	nth1(ExistingIndex, Acc, NewElement, _),
	length(Acc, AccLength),
	NewIndex is AccLength + 1,
	IndexDifference is NewIndex - ExistingIndex,
	0 =\= IndexDifference mod 2, !.

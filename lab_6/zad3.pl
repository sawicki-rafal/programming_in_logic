s1 --> [].
s1 --> [a],s1.

s2 --> [].
s2 --> [b],s2.

s3 --> s1,s2.

s4 --> [].
s4 --> [c],s4.

s5 --> s1,s2,s4.

fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N, Result) :- N1 is N - 1, N2 is N - 2, fib(N1, Result1), fib(N2, Result2), Result is Result1 + Result2.

p3 --> a(N),{fib(N,X)},b(X).

s8(X,N)-->s7(X),{fib(N,X)}.

p([]) --> [].
p([X|Xs])-->[X],p(Xs).

z --> [].
z --> [a],z,[b].

a(X) --> a(0,X).
a(X,X) -->[].
a(X,Z) -->[a],{Y is X+1},a(Y,Z).

b(X) --> b(0,X).
b(X,X) -->[].
b(X,Z) -->[b],{Y is X+1},b(Y,Z).

c(X) --> c(0,X).
c(X,X) -->[].
c(X,Z) -->[c],{Y is X+1},c(Y,Z).



z2-->a(X),b(X),c(X).

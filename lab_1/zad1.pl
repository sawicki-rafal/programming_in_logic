matka(agnieszka,rafal).
matka(agnieszka,szymon).
matka(ela,dorota).
matka(ela,marcin).

ojciec(artur,rafal).
ojciec(tomek,agnieszka).

mezczyzna(rafal).
mezczyzna(szymon).
mezczyzna(artur).
mezczyzna(tomek).

kobieta(agnieszka).
kobieta(ela).
kobieta(dorota).

rodzic(X,Y):-
    matka(X,Y);
    ojciec(X,Y).

jest_matka(X):-
    matka(X,_).

jest_ojcem(X):-
    ojciec(X,_).

jest_synem(X):-
    mezczyzna(X),
    rodzic(_,X).

siostra(X,Y):-
    kobieta(X),
    rodzic(Z,X),
    rodzic(Z,Y),
    X\=Y.

dziadek(X,Y):-
    mezczyzna(X),
    rodzic(X,Z),
    rodzic(Z,Y).

rodzenstwo(X,Y):-
    rodzic(Z,X),
    rodzic(Z,Y),
    X\=Y.

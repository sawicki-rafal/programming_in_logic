right_of(X, Y):-
	X is Y+1.
left_of(X, Y):-
	right_of(Y, X).

next_to(X, Y):-
	right_of(X, Y).
next_to(X, Y):-
	left_of(X, Y).

fish(Fish_owner) :-
    Houses = [
           house(1, Nationality1,  Color1,     Pet1,   Drink1,    Cigaretts1),
           house(2, Nationality2,  Color2,     Pet2,   Drink2,    Cigaretts2),
           house(3, Nationality3,  Color3,     Pet3,   Drink3,    Cigaretts3),
           house(4, Nationality4,  Color4,     Pet4,   Drink4,    Cigaretts4),
           house(5, Nationality5,  Color5,     Pet5,   Drink5,    Cigaretts5)],
    member(house(_, english,           red,        _,      _,          _           ), Houses),
    member(house(_, swede,         _,          dog,    _,          _           ), Houses),
    member(house(_, dane,          _,          _,      tea,        _           ), Houses),
    member(house(A, _,             green,      _,      _,          _           ), Houses),
    member(house(B, _,             white,      _,      _,          _           ), Houses),
    left_of(A, B),
    member(house(_, _,             green,      _,      coffe,     _           ), Houses),
    member(house(_, _,             _,          bird,  _,          pall_mall   ), Houses),
    member(house(_, _,             yellow,     _,      _,          dunhill     ), Houses),
    member(house(3, _,             _,          _,      milk,       _           ), Houses),
    member(house(1, norwegian,     _,          _,      _,          _           ), Houses),
    member(house(C, _,             _,          _,      _,          blend       ), Houses),
    member(house(D, _,             _,          cat,   _,          _           ), Houses),
    next_to(C, D),
    member(house(E, _,             _,          horse,  _,          _           ), Houses),
    member(house(F, _,             _,          _,      _,          dunhill     ), Houses),
    next_to(E, F),
    member(house(_, _,             _,          _,      bluemaster, beer        ), Houses),
    member(house(_, german,        _,          _,      _,          prince      ), Houses),
    member(house(G, norwegian,     _,          _,      _,          _           ), Houses),
    member(house(H, _,             blue,       _,      _,          _           ), Houses),
    next_to(G, H),
    member(house(I, _,             _,          _,      _,          blend       ), Houses),
    member(house(J, _,             _,          _,      water,      _           ), Houses),
    next_to(I, J),
    member(house(_, Fish_owner,     _,          fish,   _,          _           ), Houses).
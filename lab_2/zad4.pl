add(a,X,X).
add(s(X),Y,s(Z)):-
    add(X,Y,Z).

have(andrew,car).
have(adam,house).
have(max,map).
have(dean,gun).

give(s(a),adam,house,max).
give(s(a),andrew,car,adam).
%this means in 2 max has map, but in 3 andrew has it
give(s(s(a)),max,map,andrew).
give(s(s(s(s(s(a))))),andrew,map,max).
give(s(s(s(s(s(s(s(s(s(s(a)))))))))),max,map,andrew).

have(Time,Who,What):-
    Time=a,
    have(Who,What).

have(Time,Who,What):-
    add(s(a),TimeBefore,Time),
   give(TimeBefore,_,What,Who).


have(Time,Who,What):-
   add(s(a),TimeBefore,Time),
   have(TimeBefore,Who,What),
   \+ give(TimeBefore,Who,What,_).
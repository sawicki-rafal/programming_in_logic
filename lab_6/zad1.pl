program([]) --> [].
program([INSTRUKCJA|PROGRAM]) -->
	instrukcja(INSTRUKCJA),[sep(';')],program(PROGRAM).

instrukcja(assign(ID,WYRAZENIE)) -->
	[identifier(ID),sep(':=')],wyrazenie(WYRAZENIE).
instrukcja(read(ID)) -->
	[key(read),identifier(ID)].
instrukcja(write(WYRAZENIE)) -->
	[key(write)], wyrazenie(WYRAZENIE).
instrukcja(if(WARUNEK,PROGRAM)) -->
	[key(if)],warunek(WARUNEK),[key(then)],program(PROGRAM),[key(fi)].
instrukcja(if(WARUNEK,PROGRAM,PROGRAM2)) -->
	[key(if)],warunek(WARUNEK),[key(then)],program(PROGRAM),[key(else)],program(PROGRAM2),[key(fi)].
instrukcja(while(WARUNEK,PROGRAM)) -->
	[key(while)],warunek(WARUNEK),[key(do)],program(PROGRAM),[key(od)].

wyrazenie(SKLADNIK+WYRAZENIE) -->
	skladnik(SKLADNIK),[sep('+')],wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK-WYRAZENIE) -->
	skladnik(SKLADNIK),[sep('-')],wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK) --> skladnik(SKLADNIK).

skladnik(CZYNNIK*SKLADNIK) -->
	czynnik(CZYNNIK),[sep('*')],skladnik(SKLADNIK).
skladnik(CZYNNIK/SKLADNIK) -->
	czynnik(CZYNNIK),[sep('/')],skladnik(SKLADNIK).
skladnik(CZYNNIK mod SKLADNIK) -->
	czynnik(CZYNNIK),[key(mod)],skladnik(SKLADNIK).
skladnik(CZYNNIK) --> czynnik(CZYNNIK).

%tu sprawdzic czy nie ma kolizji nazw
czynnik(id(ID)) --> [identifier(ID)].
czynnik(int(NUM)) --> [num(NUM)].
czynnik((WYRAZENIE)) --> [sep('(')],wyrazenie(WYRAZENIE),[sep(')')].

warunek(KONIUNKCJA;WARUNEK) -->
	koniunkcja(KONIUNKCJA),[key('or')],warunek(WARUNEK).
warunek(WARUNEK) -->
	koniunkcja(WARUNEK).

koniunkcja(PROSTY,KONIUNKCJA) -->
	prosty(PROSTY),[key('and')],koniunkcja(KONIUNKCJA).

koniunkcja(KONIUNKCJA) -->
	prosty(KONIUNKCJA).

prosty(WYRAZENIE=:=WYRAZENIE2) -->
	wyrazenie(WYRAZENIE),[sep('=')],wyrazenie(WYRAZENIE2).

prosty(not(WYRAZENIE,WYRAZENIE2)) -->
	wyrazenie(WYRAZENIE),[sep('/=')],wyrazenie(WYRAZENIE2).

prosty(WYRAZENIE<WYRAZENIE2) -->
	wyrazenie(WYRAZENIE),[sep('<')],wyrazenie(WYRAZENIE2).

prosty(WYRAZENIE>WYRAZENIE2) -->
	wyrazenie(WYRAZENIE),[sep('>')],wyrazenie(WYRAZENIE2).

prosty(WYRAZENIE>=WYRAZENIE2) -->
	wyrazenie(WYRAZENIE),[sep('>=')],wyrazenie(WYRAZENIE2).

prosty(WYRAZENIE=<WYRAZENIE2) -->
	wyrazenie(WYRAZENIE),[sep('=<')],wyrazenie(WYRAZENIE2).

prosty(WARUNEK) -->
	[sep('(')],warunek(WARUNEK),[sep(')')].


scanner(Stream,Tokens):-
	get_char(Stream,Char),
	scanner(Stream,Char,Tokens).

scanner(_,end_of_file, []):-
	!.

scanner(Stream,Char,Tokens):-
	white(Char),
	!,
	get_char(Stream,NextChar),
	readWhite(Stream,NextChar,NotWhiteChar),
	scanner(Stream,NotWhiteChar,Tokens).

scanner(Stream,Char,[H|T]):-
	char_type(Char,lower),
	!,
	readKey(Stream,Char,NotKeyChar,'',H),
	scanner(Stream,NotKeyChar,T).

scanner(Stream,Char,[H|T]):-
	char_type(Char,upper),
	!,
	readID(Stream,Char,NotIDChar,'',H),
	scanner(Stream,NotIDChar,T).

scanner(Stream,Char,[H|T]):-
	char_type(Char,digit),
	!,
	readInt(Stream,Char,NotIntChar,'',H),
	scanner(Stream,NotIntChar,T).

scanner(Stream,Char,[H|T]):-
	sepChar(Char),
	!,
	readSep(Stream,Char,NotSepChar,'',H),
	scanner(Stream,NotSepChar,T).

readSep(Stream,Char,NotSepChar,Separator,Token):-
	sepChar(Char),
	!,
	atom_concat(Separator,Char,NewSeparator),
	get_char(Stream,NextChar),
	readSep(Stream,NextChar,NotSepChar,NewSeparator,Token).

readSep(_,NotSepChar,NotSepChar,Separator,Token):-
	Token=sep(Separator),
	!.

readInt(Stream,Char,NotIntChar,Int,Token):-
	char_type(Char,digit),
	!,
	atom_concat(Int,Char,NewInt),
	get_char(Stream,NextChar),
	readInt(Stream,NextChar,NotIntChar,NewInt,Token).

readInt(_,NotIntChar,NotIntChar,Int,Token):-
	Token=num(Int),
	!.

readID(Stream,Char,NotIDChar,ID,Token):-
	char_type(Char,upper),
	!,
	atom_concat(ID,Char,NewID),
	get_char(Stream,NextChar),
	readID(Stream,NextChar,NotIDChar,NewID,Token).

readID(_,NotIDChar,NotIDChar,ID,Token):-
	Token=identifier(ID),
	!.


readKey(Stream,Char,NotKeyChar,Key,Token):-
	char_type(Char,lower),
	!,
	atom_concat(Key,Char,NewKey),
	get_char(Stream,NextChar),
	readKey(Stream,NextChar,NotKeyChar,NewKey,Token).

readKey(_,NotKeyChar,NotKeyChar,Key,Token):-
	Token=key(Key),
	!.


readWhite(Stream,Char,NotWhiteChar):-
	white(Char),
	!,
	get_char(Stream,NextChar),
	readWhite(Stream,NextChar,NotWhiteChar).

readWhite(_,NotWhiteChar,NotWhiteChar):-
	!.


white(' ').
white('\t').
white('\n').

key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

num(X):-
	atom_number(X,Y),
	integer(Y).
sep(X):-
	member(X,[';','+','-','*','/','(',')','<','>','=<','>=',':=','=','/=']).

identifier(ID):-
   \+ atom_number(ID,_),
   atom_string(ID,STRING),
   string_upper(STRING,UPPERSTRING),
   UPPERSTRING=STRING.

presep(X):-
	sep(Y),
	atom_concat(X,_,Y).

sepChar(X):-
	sep(Y),
	(atom_concat(X,_,Y);atom_concat(_,X,Y)).

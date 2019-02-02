
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).

:- use_module(form).
:- use_module(queens).

:- http_handler(root(queens), handler_queens, []).
:- http_handler(root(solution), handler_solution, []).
:- http_handler(root(.), http_reply_from_files('pic', []), [prefix]).

server(Port) :-
	http_server(http_dispatch, [port(Port)]).

handler_queens(_Request) :-
	format('Content-type: text/html~n~n'),
	format('<!DOCTYPE html><html><head><title>Form</title>~n', []),
	format('<meta http-equiv="content-type" content="text/html; charset=UTF-8">~n', []),
	format('</head><body>~n', []),
	format('<h1>Gimmie size of the problem</h1>~n'),
	build_form([action(solution), method(post)],
		   [	label(size, 'Size:'), input(text, size), input(submit)]),
	format('</body></html>~n', []).

handler_solution(Request) :-
	member(method(post), Request), !,
	http_read_data(Request, Data, []),
	reply_html_page(title('Solution'),
			[h1('Solution'),
			 \queensPage(Data)
			]).

queensPage([_=Size|_]) -->
	{atom_number(Size,SizeNumber),
	queens(SizeNumber,Solution)},
	html_begin(table),
	rows(Solution,Size),
	html_end(table).

rows([],_) --> [].

rows([Index|Tail],Size) -->
	html_begin(tr),
	print_row(Index,1,Size),
	html_end(tr),
	rows(Tail,Size).

print_row(_,Current,Size)-->{atom_number(Size,SN),Current>SN},[].

print_row(Index,Current,Size)-->
	{(   (Index==Current)
	-> (SRC='queen.png');
	(   SRC='empty.png')),
	NewCurrent is Current + 1},
	html(td(img(src=SRC))),
	print_row(Index,NewCurrent,Size).



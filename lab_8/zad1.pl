:-use_module(library(sgml)).
:-use_module(library(xpath)).
:-use_module(library(url)).

servers(FILE,SERVERSET):-
    load_html(FILE,DOM,[]),
    findall(HOST,
            (xpath(DOM,//a(@href),LINK),
             parse_url(LINK,localhost,URL),
             get_host(URL,HOST)),
           SERVERLIST),
    setof(SERVER,member(SERVER,SERVERLIST),SERVERSET).

get_host(URL,HOST):-
	URL=[_,host(HOST),_].


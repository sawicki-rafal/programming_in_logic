servers(FILE,SERVERSET):-
    load_html(FILE,DOM,[]),
    findall(HOST,
            (xpath(DOM,//a,AHREF),
             get_link(AHREF,LINK),
             parse_url(LINK,localhost,URL),
             get_host(URL,HOST)),
           SERVERLIST),
    setof(SERVER,member(SERVER,SERVERLIST),SERVERSET).

get_link(AHREF,LINK):-
    AHREF=element(_,ATTRIBUTES,_),
    member(HREF,ATTRIBUTES),
    HREF=(href=LINK).

get_host(URL,HOST):-
	URL=[_,host(HOST),_].


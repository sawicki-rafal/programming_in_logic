filozofowie:-
    mutex_create(fork1),
    mutex_create(fork2),
    mutex_create(fork3),
    mutex_create(fork4),
    mutex_create(fork5),
    thread_create(filozof(fork1,fork2),X),
    thread_create(filozof(fork2,fork3),Y),
    thread_create(filozof(fork3,fork4),Z),
    thread_create(filozof(fork4,fork5),S),
    thread_create(filozof(fork5,fork1),T),
    thread_join(X),
    thread_join(Y),
    thread_join(Z),
    thread_join(S),
    thread_join(T),
    mutex_destroy(fork1),
    mutex_destroy(fork2),
    mutex_destroy(fork3),
    mutex_destroy(fork4),
    mutex_destroy(fork5).

filozof(FORK_L,FORK_R):-
    thread_self(X),
    format('[~w] mysli ~n', [X]),
    format('[~w] chce prawy widelec: ~w ~n', [X,FORK_R]),
    mutex_lock(FORK_R),
    format('[~w] podnosi prawy widelec: ~w ~n', [X,FORK_R]),
    format('[~w] chce lewy widelec: ~w ~n', [X,FORK_L]),
    mutex_lock(FORK_L),
    format('[~w] podnosi lewy widelec: ~w ~n', [X,FORK_L]),
    format('[~w] je~n',[X]),
    format('[~w] odklada prawy widelec: ~w ~n', [X,FORK_R]),
    mutex_unlock(FORK_R),
    format('[~w] odklada lewy widelec: ~w ~n', [X,FORK_L]),
    mutex_unlock(FORK_L),
    filozof(FORK_R,FORK_L).






merge(IN1,IN2,OUT):-
   freeze(IN1,
          freeze(IN2,
                 (   IN1=[X|Xs],
                     IN2=[Y|Ys],
                     (   (X<Y)
                     ->(   Z=X,(OUT=[Z|Zs],merge(Xs,[Y|Ys],Zs)))
                     ;(Z=Y, (OUT=[Z|Zs],merge([X|Xs],Ys,Zs))))))).


merge(IN1,IN2,OUT):-
    freeze(IN1,
           freeze(IN2,
                 (   (IN1==[])
                 ->  OUT=IN2
                 ;   ((IN2==[])
                     ->  OUT=IN1)))).

split(IN,OUT1,OUT2):-
   freeze(IN,
          (   IN=[I1,I2|Is],
              OUT1=[I1|O1],
              OUT2=[I2|O2],
              split(Is,O1,O2))).

split(IN,OUT1,OUT2):-
   freeze(IN,
          (   IN=[I1|Is],
              OUT1=[I1|O1],
              split(Is,O1,OUT2))).


split(IN,OUT1,OUT2):-
   freeze(IN,
        (   (IN==[])
        ->  (OUT1=[],OUT2=[]))).


merge_sort(IN,OUT):-
   freeze(IN,
          (   IN==[],
              OUT=[])).

merge_sort(IN,OUT):-
   freeze(IN,
          (   IN=[I1|Is],
              freeze(Is,
                     (   length(IN,1),
                         OUT=IN)))).

merge_sort(IN,OUT):-
   freeze(IN,(
              split(IN,TMP1,TMP2),
              merge_sort(TMP1,A),
              merge_sort(TMP2,B),
              merge(A,B,OUT))).

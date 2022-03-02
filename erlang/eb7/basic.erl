-module(basic).
-compile(export_all).

mult(X,Y) ->
    X*Y.
double(X) ->
    2*X.
distance({X1,Y1},{X2,Y2}) ->
    math:sqrt(math:pow(X2-X1,2) + math:pow(Y2-Y1,2)).
my_and(X,Y) ->
    if 
        X ->
            if 
                Y -> true;
                true -> false
            end;
        true -> 
            false
    end.
my_or(X,Y) ->
    if
        X ->
          true;  
        true ->
            if
                Y ->
                    true;
                true ->
                    false
            end
    end.
my_not(X) ->
    if
        X ->
            false;
        true ->
            true
    end.
fibonacci(N) ->
    if
        (N == 0) or (N == 1) ->
            1;
        true ->
            fibonacci(N-1) + fibonacci(N-2)            
    end.

fibonacciTR(0) ->
    1;
fibonacciTR(1) ->
    1;
fibonacciTR(N) ->
    fibonacciTR(N-1) + fibonacciTR(N-2).

sum([]) ->
    0;
sum([H|T]) ->
    H+sum(T).

maximum([],M) ->
    M;
maximum([H|T],M) ->
    if
        H > M ->
            maximum(T,H);
        true ->
            maximum(T,M)    
    end.
maximum([]) ->
    0;
maximum([H|T]) ->
    maximum(T,H).

evenL([]) ->
    [];
evenL([_]) ->
    [];
evenL([_|[H2|T]]) ->
    [H2|evenL(T)].

take(0,_) ->
    [];
take(_,[]) ->
    [];
take(N,[H|T]) ->
    [H|take(N-1,T)].

drop(0,L) ->
    L;
drop(_,[]) ->
    [];
drop(N,[_|T]) ->
    drop(N-1,T).
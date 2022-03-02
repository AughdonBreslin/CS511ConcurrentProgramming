-module(barr).
-compile(export_all).

start() ->
    B = spawn(?MODULE,loop,[2,2,[]]),
    spawn(?MODULE,client1,[B]),
    spawn(?MODULE,client2,[B]).
% loop(N,M,L)
% the main loop for a barrier of size N
% M is the number of threads yet to reach the barrier
% L is the list of PID,Ref of the threads that have 
    % already reached the barrier
loop(N,0,L) -> 
    %% notify threads they can fall through and restart barrier
    lists:map(fun({PID,Ref}) -> PID!{ok,Ref} end, L),
    loop(N,N,[]);
loop(N,M,L) -> 
    %% wait for another thread to arrive
    receive
        {PID,Ref} -> loop(N,M-1,[{PID,Ref}]++L)
    end.
reached(B) ->
    R = make_ref(),
    B!{self(),R},
    receive
        {ok,R} ->
            ok
    end.
client1(B) ->
    io:format("a~n"),
    reached(B),
    io:format("1~n").
client2(B) ->
    io:format("b~n"),
    reached(B),
    io:format("2~n").
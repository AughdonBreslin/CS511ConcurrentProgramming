-module(client).
-compile(export_all).

start() ->
    S = semaphore:start_sem(0),
    spawn(?MODULE,client1,[S]),
    spawn(?MODULE,client2,[S]).

% C after A

client1(S) ->
    io:format("a~n"),
    semaphore:release(S).

client2(S) ->
    semaphore:acquire(S),
    io:format("c~n").
-module(eb8ex1).
-compile(export_all).

start(N) -> %% Spawns a counter and N turnstile clients
    C = spawn(?MODULE, counter_server, [0]),
    [spawn(?MODULE, turnstile, [C,50]) || _ <- lists:seq(1,N)],
    C.
counter_server(State) -> 
    %% State is the current value of the counter
    receive
        {bump} ->
            counter_server(State+1);
        {done,PID} ->
            io:format("Turnstile ~w finished, count at ~w~n", [PID, State]),
            counter_server(State)
end.

turnstile(C,0) ->
    %% C is the PID of the counter, and
    %% N is the number of times the turnstile turns
    C!{done,self()};
turnstile(C,N) when N>0 -> 
    C!{bump},
    turnstile(C,N-1).
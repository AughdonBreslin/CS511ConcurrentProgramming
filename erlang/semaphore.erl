-module(semaphore).
-compile(export_all).


start_sem(Init) -> %% N = num of initial permits
    spawn(?MODULE, semaphore_loop, [Init]).

semaphore_loop(0) -> %% only process "release"
    receive
        {release} ->
            semaphore_loop(1)
end;
semaphore_loop(P) when P>0 -> %% process "release" and "acquire"
    receive
        {release} ->
            semaphore_loop(P+1);
        {acquire,From} ->
            From!{ack},
            semaphore_loop(P-1)
end.

acquire(S) -> % S is PID of semaphore server
    S!{acquire,self()},
    receive
        {ack} ->
            done
end.

release(S) -> % S is PID of semaphore server
    S!{release}.

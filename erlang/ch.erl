-module(ch).
-compile(export_all).

chain(0) ->
    receive
        _ -> ok
        after 2000 -> exit(oops)
    end;
chain(N) when N>0 ->
    spawn_link(?MODULE,chain,[N-1]),
    receive
        _ -> ok
    end.
-module(echoServer).
-compile(export_all).


echo() ->
    receive
        {From,Data} ->
            From!Data,
            echo();
        stop ->
            stop
end.

client(S) ->
    S!{self(),rand:uniform(100)},
    receive
        X -> io:format("Got back ~p.", [X])
end.

start() ->
    S = spawn(?MODULE,echo,[]),
    [spawn(?MODULE,client, [S]) || _ <- lists:seq(1,1000)],
    S.

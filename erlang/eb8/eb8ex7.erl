-module(bar2).
-compile(export_all).

start (W ,M) ->
    S=spawn(?MODULE, server,[0 ,0 ,false]),
    [spawn(?MODULE, patriots ,[S]) || _ <- lists : seq (1 , W)],
    [spawn(?MODULE, jets, [S]) || _ <- lists : seq (1 , M)],
    spawn(?MODULE, itGotLate, [3000, S]).

patriots(S) -> % Reference to PID of server
    S!{self(),patriots}.

jets (S) -> % Reference to PID of server
    Ref = make_ref(),
    S!{self(),Ref,jets},
    receive
        {S,Ref,ok} ->
            ok
    end.

server(Patriots) -> % Counters for Patriots available for justifying ingress of Jets , false =it
    % did not get late yet
    receive
        {_,patriots} ->
            server(Patriots+1);
        {PID, Ref, jets} when Patriots>1 ->
            PID!{self(),Ref,ok},
            server(Patriots-2)
    end.

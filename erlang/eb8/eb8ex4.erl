-module(eb8ex4).
-compile(export_all).

start(T) ->
    L = [spawn(?MODULE,client,[]) || _ <-lists:seq(1,10)],
    spawn(?MODULE,timer,[T,L]).

timer(Frequency,L) ->
    timer:sleep(Frequency),
    [ Pid!{tick} || Pid <- L],
    timer(Frequency,L).

client() ->
    receive
        {tick} -> client()
    end.

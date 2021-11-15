-module(dc).
-compile(export_all).
	
start(E,M) ->
    DC = spawn(?MODULE,dryCleaner,[0,0]),
    [ spawn(?MODULE,employee,[DC]) || _ <- lists:seq(1,E) ],
    [ spawn(?MODULE,dryCleanMachine,[DC]) || _ <- lists:seq(1,M) ].
            
dryCleaner(Clean,Dirty) -> %% Clean, Dirty are counters
    receive
        {dropOffOverall} ->
            dryCleaner(Clean,Dirty+1);
        {From,dryCleanItem} when Dirty > 0->
            From!{ok},
            dryCleaner(Clean+1,Dirty-1);
        {From, pickUpOverall} when Clean > 0 ->
            From!{ok},
            dryCleaner(Clean-1,Dirty)
end.

employee(DC) -> % drop off overall, then pick up a clean one (if none
                % is available, wait), and end
    DC!{dropOffOverall},
    DC!{self(),pickUpOverall},
    receive
        {ok} ->
            ok
    end.

dryCleanMachine(DC) ->  % dry clean item (if none are available, wait),
                        % then sleep for 1000 milliseconds and repeat
    DC!{self(),dryCleanItem},
    timer:sleep(1000),
    dryCleanMachine(DC).


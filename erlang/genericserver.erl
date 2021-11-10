-module(genericserver).
-compile(export_all).

start(F) ->
    spawn(?MODULE,loop,[F,0]).


loop(F,S) ->
    receive
        {req,Ref,From,Input} ->
            case catch(F(S,Input)) of
                {'EXIT',Err} ->
                    From!{Ref, Err, error},
                    loop(F,S);
                {NewState,Res} ->
                    From!{Ref,Res,ok},
                    loop(F,NewState)
            end;
        stop ->
            stop;
        {update,G} ->
            loop(G,S);
        {read,Ref,From} ->
            From!{Ref,S},
            loop(F,S)
    end.
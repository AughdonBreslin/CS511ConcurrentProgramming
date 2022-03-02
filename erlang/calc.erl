%%% Stub for Quiz 6
% Aughdon Breslin Jason Rossi

-module(calc).
-compile(export_all).

env() -> #{"x"=>3, "y"=>7}.

e1() ->
    {add, 
     {const,3},
     {divi,
      {var,"x"},
      {const,4}}}.

e2() ->
    {add, 
     {const,3},
     {divi,
      {var,"x"},
      {const,0}}}.

e3() ->
    {add, 
     {const,3},
     {divi,
      {var,"r"},
      {const,4}}}.

calc({const,N},_E) ->
    {const,N};
calc({var,Id},E) ->
    case maps:find(Id,E) of
        error -> throw(unbound_identifier_error);
        {ok,N} -> {val,N}
end;
calc({add,E1,E2},E) ->
    {var,N1} = calc(E1,E),
    {var,N2} = calc(E2,E),
    {val,N1+N2};

calc({sub,E1,E2},E) ->
    {var,N1} = calc(E1,E),
    {var,N2} = calc(E2,E),
    {val,N1-N2};

calc({mult,E1,E2},E) ->
    {var,N1} = calc(E1,E),
    {var,N2} = calc(E2,E),
    {val,N1*N2};

calc({divi,E1,E2},E) ->
    {var,N1} = calc(E1,E),
    {var,N2} = calc(E2,E),
    case N2 of
        0 -> throw(division_by_zero_error);
        _ -> {val,N1/N2}
end.



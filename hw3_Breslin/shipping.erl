
-module(shipping).
-compile(export_all).
-include_lib("./shipping.hrl").

%
% Aughdon Breslin 
%

get_ship(Shipping_State, Ship_ID) ->
    % match Ship_ID to #ship.id, looking in shipping_state.ships
    case lists:keysearch(Ship_ID,#ship.id,Shipping_State#shipping_state.ships) of
        false -> error;
        {value,N} -> N
    end.

get_container(Shipping_State, Container_ID) ->
    % match Cont_ID to #cont.id, looking in shipping_state.containers
    case lists:keysearch(Container_ID,#container.id,Shipping_State#shipping_state.containers) of
        false -> error;
        {value,N} -> N
    end.

get_port(Shipping_State, Port_ID) ->
    % match Port_ID to #port.id, looking in shipping_state.orts
    case lists:keysearch(Port_ID,#port.id,Shipping_State#shipping_state.ports) of
        false -> error;
        {value,N} -> N
    end.

get_occupied_docks(Shipping_State, Port_ID) ->
    % fun: take in a location, if it matches our ID, return it
    % Using fun, check all locations for our Port_ID and 
    %    get the corresponding docks
    lists:filtermap(fun({PID,DID,_SID}) ->
        case PID of
            Port_ID -> {true,DID};
            _ -> false
        end
    end,
    Shipping_State#shipping_state.ship_locations).

get_ship_location(Shipping_State, Ship_ID) ->
    % first, check if the ship exists
    case get_ship(Shipping_State, Ship_ID) of
        error -> error;
        _ ->
            % get a list of the locations where Ship_ID is at
            % (will only ever be one location, so take its head)
            hd(
                lists:filtermap(fun({PID,DID,SID}) ->
                    case SID of
                        Ship_ID -> {true,{PID,DID}};
                        _ -> false
                    end
                end,
                Shipping_State#shipping_state.ship_locations)
            )
    end.

% helper for get_container_weight
one_container_weight(Shipping_State, Container_ID) ->
    case get_container(Shipping_State, Container_ID) of
        error -> error;
        {_,_,W} -> W
    end.

get_container_weight(Shipping_State, Container_IDs) ->
    case Container_IDs of
        [] -> 0;
        [H | T] -> case one_container_weight(Shipping_State,H) of
                        error -> error;
                        W ->case get_container_weight(Shipping_State, T) of
                                error -> error;
                                N -> W + N
                            end
                   end
    end.

get_ship_weight(Shipping_State, Ship_ID) ->
    case maps:find(Ship_ID,Shipping_State#shipping_state.ship_inventory) of
        {ok,N} -> get_container_weight(Shipping_State,N);
        _ -> error
    end.

% helpers for load_ship
% helper for helper check_locations o_0
get_container_location(Inventory,ID,Container_ID) ->
    case maps:find(ID,Inventory) of
        {ok, N} -> lists:member(Container_ID,N);
        error -> error
    end.

check_locations(Inventory, ID, Container_IDs) ->
    case Container_IDs of
        [] -> true;
        [H | T] ->  case get_container_location(Inventory,ID,H) of
                        true -> true and check_locations(Inventory, ID, T);
                        _ -> false
                    end
    end.

delete_containers(Container_IDs,L) ->
    case Container_IDs of
        [H | T] -> delete_containers(T,lists:delete(H,L));
        _ -> L
    end.

load_ship(Shipping_State, Ship_ID, Container_IDs) ->
    % get port and dock of ship, also checks if ship exists    
    case get_ship_location(Shipping_State,Ship_ID) of
        error -> error;
        % get port and dock of containers
        {Port,_} -> case check_locations(Shipping_State#shipping_state.port_inventory, Port, Container_IDs) of
                        % if any container location is not ship's -> error
                        false -> error;
                        % if total num of containers > 20
                        true -> {_,_,_,ShipCap} = get_ship(Shipping_State, Ship_ID),
                                {ok, ShipContainers} = maps:find(Ship_ID,Shipping_State#shipping_state.ship_inventory), 
                                case length([X || X <- ShipContainers, X < 1]) + length([X || X <- Container_IDs, X < 1]) > ShipCap of
                                    true -> error;
                                    false ->{ok,L} = maps:find(Port,Shipping_State#shipping_state.port_inventory),
                                            % remove containers from port 
                                            M = maps:update(Port,delete_containers(Container_IDs,L),Shipping_State#shipping_state.port_inventory),
                                            % add to ship inventory
                                            N = maps:update(Ship_ID,lists:append([ShipContainers,Container_IDs]),Shipping_State#shipping_state.ship_inventory),
                                            % display the new state
                                            {ok, #shipping_state{
                                                ships = Shipping_State#shipping_state.ships,
                                                containers = Shipping_State#shipping_state.containers,
                                                ports = Shipping_State#shipping_state.ports,
                                                ship_locations = Shipping_State#shipping_state.ship_locations,
                                                ship_inventory = N,
                                                port_inventory = M}
                                            }
                                end
                    end
    end.

unload_ship_all(Shipping_State, Ship_ID) ->
    % check if ship exists
    case get_ship(Shipping_State,Ship_ID) of
        error -> error;
        _ ->% get a list of the containers on the ship
            {ok, ShipConts} = maps:find(Ship_ID,Shipping_State#shipping_state.ship_inventory),
            % get port and dock of ship
            {PortU, _} = get_ship_location(Shipping_State,Ship_ID),
            % get a list of containers at the port
            {ok, PortConts} = maps:find(PortU,Shipping_State#shipping_state.port_inventory),
            {_,_,_,_,PortCap} = get_port(Shipping_State, PortU),

            % check if num_containers + num_at_port > port_cap
            case length([X || X <- ShipConts]) + length([X || X <- PortConts]) > PortCap of
                true -> error;
                false ->
                        % remove containers from ship
                        M = maps:update(Ship_ID,[],Shipping_State#shipping_state.ship_inventory),
                        % add to port
                        {ok,L2} = maps:find(PortU,Shipping_State#shipping_state.port_inventory),
                        N = maps:update(PortU,lists:append([L2,ShipConts]),Shipping_State#shipping_state.port_inventory),
                        % display new state
                        {ok, #shipping_state{
                            ships = Shipping_State#shipping_state.ships,
                            containers = Shipping_State#shipping_state.containers,
                            ports = Shipping_State#shipping_state.ports,
                            ship_locations = Shipping_State#shipping_state.ship_locations,
                            ship_inventory = M,
                            port_inventory = N}}
            end
    end.

unload_ship(Shipping_State, Ship_ID, Container_IDs) ->
    % check if ship exists
    case get_ship(Shipping_State,Ship_ID) of
        error -> error;
        _ ->% check that containers are on the ship
            case check_locations(Shipping_State#shipping_state.ship_inventory, Ship_ID, Container_IDs) of
                false -> error;
                true -> {Port, _} = get_ship_location(Shipping_State,Ship_ID),
                        % get a list of containers at the port
                        {ok, PortConts} = maps:find(Port,Shipping_State#shipping_state.port_inventory),
                        % get the port capacity
                        {_,_,_,_,PortCap} = get_port(Shipping_State, Port),
                        % if containersToRemove + PortConts > portCapacity, then error out, else continue
                        case length([X || X <- Container_IDs]) + length([X || X <- PortConts]) > PortCap of
                            true -> error;
                            false ->{ok,L} = maps:find(Ship_ID,Shipping_State#shipping_state.ship_inventory), 
                                    % remove containers from ship 
                                    M = maps:update(Ship_ID,delete_containers(Container_IDs,L),Shipping_State#shipping_state.ship_inventory),
                                    % add to port
                                    {ok,L2} = maps:find(Port,Shipping_State#shipping_state.port_inventory),
                                    N = maps:update(Port,lists:append([L2,Container_IDs]),Shipping_State#shipping_state.port_inventory),
                                    % display new state
                                    {ok, #shipping_state{
                                        ships = Shipping_State#shipping_state.ships,
                                        containers = Shipping_State#shipping_state.containers,
                                        ports = Shipping_State#shipping_state.ports,
                                        ship_locations = Shipping_State#shipping_state.ship_locations,
                                        ship_inventory = M,
                                        port_inventory = N}}
                        end
            end
    end.

set_sail(Shipping_State, Ship_ID, {Port_ID, Dock}) ->
    % check if ship exists
    case get_ship(Shipping_State,Ship_ID) of
        error -> error;
        _ ->% check if specified port, dock exists
        case lists:member(Port_ID, [1,2,3]) and lists:member(Dock, ['A','B','C','D']) of
            false -> error;
            true -> % check if specified port,dock is occupied % get ports and docks from ship locations
                    case lists:member({Port_ID,Dock},lists:map(fun({PID,DID,_}) -> {PID,DID} end,
                    Shipping_State#shipping_state.ship_locations)) of
                        true -> error;
                        false ->% remove ship from location
                                {P,D} = get_ship_location(Shipping_State,Ship_ID),
                                L = lists:delete({P,D,Ship_ID},Shipping_State#shipping_state.ship_locations),
                                % add new ship location
                                L2 = lists:append([[{Port_ID,Dock,Ship_ID}],L]),
                                % display new state
                                {ok, #shipping_state{
                                    ships = Shipping_State#shipping_state.ships,
                                    containers = Shipping_State#shipping_state.containers,
                                    ports = Shipping_State#shipping_state.ports,
                                    ship_locations = L2,
                                    ship_inventory = Shipping_State#shipping_state.ship_inventory,
                                    port_inventory = Shipping_State#shipping_state.port_inventory}}
                    end
        end
    end. 

%% Determines whether all of the elements of Sub_List are also elements of Target_List
%% @returns true is all elements of Sub_List are members of Target_List; false otherwise
is_sublist(Target_List, Sub_List) ->
    lists:all(fun (Elem) -> lists:member(Elem, Target_List) end, Sub_List).

%% Prints out the current shipping state in a more friendly format
print_state(Shipping_State) ->
    io:format("--Ships--~n"),
    _ = print_ships(Shipping_State#shipping_state.ships, Shipping_State#shipping_state.ship_locations, Shipping_State#shipping_state.ship_inventory, Shipping_State#shipping_state.ports),
    io:format("--Ports--~n"),
    _ = print_ports(Shipping_State#shipping_state.ports, Shipping_State#shipping_state.port_inventory).

%% helper function for print_ships
get_port_helper([], _Port_ID) -> error;
get_port_helper([ Port = #port{id = Port_ID} | _ ], Port_ID) -> Port;
get_port_helper( [_ | Other_Ports ], Port_ID) -> get_port_helper(Other_Ports, Port_ID).

print_ships(Ships, Locations, Inventory, Ports) ->
    case Ships of
        [] ->
            ok;
        [Ship | Other_Ships] ->
            {Port_ID, Dock_ID, _} = lists:keyfind(Ship#ship.id, 3, Locations),
            Port = get_port_helper(Ports, Port_ID),
            {ok, Ship_Inventory} = maps:find(Ship#ship.id, Inventory),
            io:format("Name: ~s(#~w)    Location: Port ~s, Dock ~s    Inventory: ~w~n", [Ship#ship.name, Ship#ship.id, Port#port.name, Dock_ID, Ship_Inventory]),
            print_ships(Other_Ships, Locations, Inventory, Ports)
    end.

print_containers(Containers) ->
    io:format("~w~n", [Containers]).

print_ports(Ports, Inventory) ->
    case Ports of
        [] ->
            ok;
        [Port | Other_Ports] ->
            {ok, Port_Inventory} = maps:find(Port#port.id, Inventory),
            io:format("Name: ~s(#~w)    Docks: ~w    Inventory: ~w~n", [Port#port.name, Port#port.id, Port#port.docks, Port_Inventory]),
            print_ports(Other_Ports, Inventory)
    end.

%% This functions sets up an initial state for this shipping simulation. You can add, remove, or modidfy any of this content. This is provided to you to save some time.
%% @returns {ok, shipping_state} where shipping_state is a shipping_state record with all the initial content.
shipco() ->
    Ships = [#ship{id=1,name="Santa Maria",container_cap=20},
              #ship{id=2,name="Nina",container_cap=20},
              #ship{id=3,name="Pinta",container_cap=20},
              #ship{id=4,name="SS Minnow",container_cap=20},
              #ship{id=5,name="Sir Leaks-A-Lot",container_cap=20}
             ],
    Containers = [
                  #container{id=1,weight=200},
                  #container{id=2,weight=215},
                  #container{id=3,weight=131},
                  #container{id=4,weight=62},
                  #container{id=5,weight=112},
                  #container{id=6,weight=217},
                  #container{id=7,weight=61},
                  #container{id=8,weight=99},
                  #container{id=9,weight=82},
                  #container{id=10,weight=185},
                  #container{id=11,weight=282},
                  #container{id=12,weight=312},
                  #container{id=13,weight=283},
                  #container{id=14,weight=331},
                  #container{id=15,weight=136},
                  #container{id=16,weight=200},
                  #container{id=17,weight=215},
                  #container{id=18,weight=131},
                  #container{id=19,weight=62},
                  #container{id=20,weight=112},
                  #container{id=21,weight=217},
                  #container{id=22,weight=61},
                  #container{id=23,weight=99},
                  #container{id=24,weight=82},
                  #container{id=25,weight=185},
                  #container{id=26,weight=282},
                  #container{id=27,weight=312},
                  #container{id=28,weight=283},
                  #container{id=29,weight=331},
                  #container{id=30,weight=136}
                 ],
    Ports = [
             #port{
                id=1,
                name="New York",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=2,
                name="San Francisco",
                docks=['A','B','C','D'],
                container_cap=200
               },
             #port{
                id=3,
                name="Miami",
                docks=['A','B','C','D'],
                container_cap=200
               }
            ],
    %% {port, dock, ship}
    Locations = [
                 {1,'B',1},
                 {1, 'A', 3},
                 {3, 'C', 2},
                 {2, 'D', 4},
                 {2, 'B', 5}
                ],
    Ship_Inventory = #{
      1=>[14,15,9,2,6],
      2=>[1,3,4,13],
      3=>[],
      4=>[2,8,11,7],
      5=>[5,10,12]},
    Port_Inventory = #{
      1=>[16,17,18,19,20],
      2=>[21,22,23,24,25],
      3=>[26,27,28,29,30]
     },
    #shipping_state{ships = Ships, containers = Containers, ports = Ports, ship_locations = Locations, ship_inventory = Ship_Inventory, port_inventory = Port_Inventory}.

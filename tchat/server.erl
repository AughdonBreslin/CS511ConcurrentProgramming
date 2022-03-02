%"I pledge my honor that I have abided by the Stevens Honor System." - Harrison Chachko and Matthew Viafora
-module(server).

-export([start_server/0]).

-include_lib("./defs.hrl").

-spec start_server() -> _.
-spec loop(_State) -> _.
-spec do_join(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_leave(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_new_nick(_State, _Ref, _ClientPID, _NewNick) -> _.
-spec do_client_quit(_State, _Ref, _ClientPID) -> _NewState.

start_server() ->
    catch(unregister(server)),
    register(server, self()),
    case whereis(testsuite) of
	undefined -> ok;
	TestSuitePID -> TestSuitePID!{server_up, self()}
    end,
    loop(
      #serv_st{
	 	nicks = maps:new(), %% nickname map. client_pid => "nickname"
	 	registrations = maps:new(), %% registration map. "chat_name" => [client_pids]
	 	chatrooms = maps:new() %% chatroom map. "chat_name" => chat_pid
	}
    ).

loop(State) ->
    receive 
	%% initial connection
	{ClientPID, connect, ClientNick} ->
	    NewState =
		#serv_st{
		   nicks = maps:put(ClientPID, ClientNick, State#serv_st.nicks),
		   registrations = State#serv_st.registrations,
		   chatrooms = State#serv_st.chatrooms
		  },
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, join, ChatName} ->
	    NewState = do_join(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, leave, ChatName} ->
	    NewState = do_leave(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to register a new nickname
	{ClientPID, Ref, nick, NewNick} ->
	    NewState = do_new_nick(State, Ref, ClientPID, NewNick),
	    loop(NewState);
	%% client requests to quit
	{ClientPID, Ref, quit} ->
	    NewState = do_client_quit(State, Ref, ClientPID),
	    loop(NewState);
	{TEST_PID, get_state} ->
	    TEST_PID!{get_state, State},
	    loop(State)
    end.

%% executes join protocol from server perspective
do_join(ChatName, ClientPID, Ref, State) ->
	%Step 4 & 5: Check if chatroom already exists and lookup Nickname
	ClientNick = maps:get(ClientPID, State#serv_st.nicks),
	case maps:is_key(ChatName, State#serv_st.chatrooms) of
		false ->
			Chatroom = spawn(chatroom, start_chatroom, [ChatName]),
			Newroom = maps:put(ChatName, Chatroom, State#serv_st.chatrooms),
			%Step 6: Send message to chatroom
			Chatroom ! {self, Ref, register, ClientPID, ClientNick},
			%Step 7: Update chatroom registrations
			#serv_st{
			   nicks = State#serv_st.nicks,
			   registrations = maps:put(ChatName, [ClientPID], State#serv_st.registrations),
			   chatrooms = Newroom
			};
		true ->
			%Step 6: Send message to chatroom
			Chatroom = maps:get(ChatName, State#serv_st.chatrooms),
			Chatroom ! {self, Ref, register, ClientPID, ClientNick},
			%Step 7: Update chatroom registrations
			#serv_st{
			   nicks = State#serv_st.nicks,
			   registrations = maps:update(ChatName, [ClientPID] ++ maps:get(ChatName, State#serv_st.registrations), State#serv_st.registrations),
			   chatrooms = State#serv_st.chatrooms
			}
	end.

%% executes leave protocol from server perspective
do_leave(ChatName, ClientPID, Ref, State) ->
	%Step 4: Lookup chatroom's PID
	ChatroomPID = maps:get(ChatName, State#serv_st.chatrooms),
	%Step 5: Remove client from registrations
	UpdatedClients = lists:delete(ClientPID, maps:get(ChatName, State#serv_st.registrations)),
	%Step 6: Send message to Chatroom
	ChatroomPID ! {self(), Ref, unregister, ClientPID},
	%Step 7: send message to client
	ClientPID ! {self(), Ref, ack_leave},
	#serv_st{
	   nicks = State#serv_st.nicks,
	   registrations = maps:update(ChatName, UpdatedClients, State#serv_st.registrations),
	   chatrooms = State#serv_st.chatrooms
	}.

%% executes new nickname protocol from server perspective
do_new_nick(State, Ref, ClientPID, NewNick) ->
	case lists:member(NewNick, maps:values(State#serv_st.nicks)) of
		%Step 4: If nickname is already in use send message to client
		true ->
			ClientPID!{self(), Ref, err_nick_used},
			State;
		_-> 
			%Step 5: Update record of nicknames
			UpdatedNicks = maps:update(ClientPID, NewNick, State#serv_st.nicks),
			%Step 6: Update and message chatrooms
			FindNames = fun(_,V) ->  lists:member(ClientPID, V) end,
			ChatNames = maps:keys(maps:filter(FindNames, State#serv_st.registrations)),
			Chatrooms = maps:to_list(maps:with(ChatNames, State#serv_st.chatrooms)),
			SendMsg = fun({_,V}) -> V ! {self(), Ref, update_nick, ClientPID, NewNick} end,
			lists:foreach(SendMsg, Chatrooms),
			%Step 7: Send message to client
			ClientPID !{self(), Ref, ok_nick},
			#serv_st{
				nicks = UpdatedNicks,
				registrations = State#serv_st.registrations,
				chatrooms = State#serv_st.chatrooms
		   	}
	end.

%% executes client quit protocol from server perspective
do_client_quit(State, Ref, ClientPID) ->
    %Step 3a: Remove client from nicknames 
	UpdatedNicks = maps:remove(ClientPID,State#serv_st.nicks),
	%Step 3b: Update Chatrooms
	FindNames = fun(_,V) ->  lists:member(ClientPID, V) end,
	ChatNames = maps:keys(maps:filter(FindNames, State#serv_st.registrations)),
	Chatrooms = maps:to_list(maps:with(ChatNames, State#serv_st.chatrooms)),
	SendMsg = fun({_,V}) -> V ! {self(), Ref, unregister, ClientPID} end,
	lists:foreach(SendMsg, Chatrooms),
	%Step 3c: Remove client from registration
	UpdatedRegistration = maps:without(ChatNames, State#serv_st.registrations),
	% Step 4: Send message to the client
	ClientPID !{self(), Ref, ack_quit},
	#serv_st{
		nicks = UpdatedNicks,
		registrations = UpdatedRegistration,
		chatrooms = State#serv_st.chatrooms
	}.
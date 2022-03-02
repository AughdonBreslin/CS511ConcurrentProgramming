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
    %% Step 3.2.4: Server needs to check if chatroom exists
	case maps:find(ChatName, State#serv_st.chatrooms) of
		%% Chatroom exists
		{ok,ChatPID2} -> %% Step 3.2.5: Server looks up client nickname
						ClientNick = maps:get(ClientPID, State#serv_st.nicks),

						%% Step 3.2.6: Server tells chatroom that client is joining
						ChatPID2!{self,Ref,register,ClientPID,ClientNick},
						% chatroom now needs to update

						%% Step 3.2.7: Server updates its record to include client (and new chatroom)
						#serv_st{
							nicks = State#serv_st.nicks,
							registrations = map:update(ChatName, [ClientPID] ++ maps:get(ChatName, State#serv_st.registrations), State#serv_st.registrations),
							chatrooms = State#serv_st.chatrooms
						};

		%% Chatroom doesn't exist
		error -> %% Step 3.2.4: Server must spawn chatroom
				 ChatPID = spawn(chatroom, start_chatroom, [ChatName]),

				 %% Step 3.2.5: Server looks up client nickname
				 ClientNick = maps:get(ClientPID, State#serv_st.nicks),

				 %% Step 3.2.6: Server tells chatroom that client is joining
				 ChatPID!{self,Ref,register,ClientPID,ClientNick}
				 % chatroom now needs to update
				 
				 %% Step 3.2.7: Server updates its record to include client
				 #serv_st{
					 nicks = State#serv_st.nicks,
					 registrations = maps:put(ChatName, [ClientPID], State#serv_st.registrations),
					 chatrooms = maps:put(ChatName, ChatPID, State#serv_st.chatrooms)
				 }
	end.

%% executes leave protocol from server perspective
do_leave(ChatName, ClientPID, Ref, State) ->
    %% Step 3.3.4: Server looks up ChatPID from serv_st
	ChatPID = maps:get(ChatName, State#serv_st.chatrooms),

	%% Step 3.3.5: Remove client from its local record of cr regs
	ChatRegs = maps:get(ChatName, State#serv_st.registrations),
	RemovedRegs = lists:delete(ClientPID, ChatRegs),

	%% Step 3.3.6: Server sends message to chatroom
	ChatPID!{self(), Ref, unregister, ClientPID},

	%% Step 3.3.7: Server sends message to client
	ClientPID!{self(), ref, ack_leave},

	%% Update state w removed client
	#serv_st{
		nicks = State#serv_st.nicks,
		registrations = maps:put(ChatName, RemovedRegs, State#serv_st.registrations),
		chatrooms = State#serv_st.chatrooms
	}.



%% executes new nickname protocol from server perspective
do_new_nick(State, Ref, ClientPID, NewNick) ->
    io:format("server:do_new_nick(...): IMPLEMENT ME~n"),
    State.

%% executes client quit protocol from server perspective
do_client_quit(State, Ref, ClientPID) ->
    io:format("server:do_client_quit(...): IMPLEMENT ME~n"),
    State.

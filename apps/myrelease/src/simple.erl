-module(simple).

 -export([server/1,client/1,start/1,spawn_n/2,main/1]).



 server(State) ->
 receive
 {request,Return_PID} ->
 io:format("SERVER ~w: Client request received from ~w~n",
 [self(), Return_PID]) ,
 NewState = State + 1,
 Return_PID ! {hit_count,NewState},
 server(NewState)
 end.

 client(Server_Address) ->
 Server_Address ! {request, self()},
 receive
 {hit_count,Number} ->
 io:format("CLIENT ~w: Hit count was ~w~n",[self(), Number])
 end.




spawn_n(N,Server_PID) ->
    if
    N>0 ->
    spawn(simple,client,[Server_PID]),
    %% Use a random sleep in miliseconds to simulate the
    %% client traffic pattern.
    timer:sleep(random:uniform(100)),
    spawn_n(N-1,Server_PID);
    N == 0 ->
    io:format("Last client spawned.~n")
    end.

 start(N) ->
 Server_PID = spawn(simple,server,[0]),
 spawn(simple,client,[Server_PID]).

main([Arg]) ->
     N = list_to_integer(atom_to_list(Arg)),
     start(N),
     init:stop().
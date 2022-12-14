-module (message_router).

-compile(export_all).

start() ->
    spawn(message_router, route_messages, []).

stop(RouterPid) ->
    RouterPid ! shutdown.

route_messages() ->
    receive
        {send_chat_msg, Addressee, MessageBody} ->
            Addressee ! {recv_chat_msg, MessageBody},
            route_messages();
        {recv_chat_msg, MessageBody} ->
            io:format("Received: ~p~n", [MessageBody]);
        shutdown ->
            io:format("Shutting down~n");
        Oops ->
            io:format("Warning! Received: ~p~n", [Oops]),
            route_messages()
    end.

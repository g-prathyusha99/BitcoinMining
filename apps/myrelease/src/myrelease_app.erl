%%%-------------------------------------------------------------------
%% @doc myrelease public API
%% @end
%%%-------------------------------------------------------------------

-module(myrelease_app).
% -compile(export_all).
-behaviour(application).

-export([start/2, stop/1]).

% -export([hello_world/0]).

	% hello_world() -> io:fwrite("hello, world\n").

% Bits = entropy_string:bits(10000, 1000000).
% lists:map(fun(_) -> entropy_string:random_string(Bits, charset16) end, lists:seq(1,5)).


start(_StartType, _StartArgs) ->
    myrelease_sup:start_link().

stop(_State) ->
    ok.

% internal functions

-module(statistics_server).

%% this file was generated by grpc

-export([decoder/0, get_stats/3]).

-type
     'type_parameter.stats_type'() :: microstate_accounting.

-type 'thread.thread_type'() :: async | scheduler | aux.

-type counter_stat() :: #{aux => integer(),
                          check_io => integer(), emulator => integer(),
                          other => integer(), port => integer(),
                          sleep => integer()}.

-type thread() :: #{counters => counter_stat(),
                    id => integer(),
                    type => 'thread.thread_type'() | integer()}.

-type stats() :: #{threads => [thread()]}.

-type type_parameter() :: #{type_field =>
                                'type_parameter.stats_type'() | integer()}.

-spec decoder() -> module().

%% The module (generated by gpb) used to encode and decode protobuf
%% messages.
decoder() -> statistics.

%% RPCs for service get_stats

-spec get_stats(Message :: type_parameter(),
                Stream :: grpc:stream(), State :: any()) -> {stats(),
                                                             grpc:stream()} |
                                                            grpc:error_response().

%% This is a unary RPC
get_stats(#{type_field := Type}, Stream, _State) ->
    Stats = erlang:statistics(Type),
    {#{threads => Stats}, Stream}.

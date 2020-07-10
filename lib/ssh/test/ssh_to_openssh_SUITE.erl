%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2008-2020. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%%
-module(ssh_to_openssh_SUITE).

-include_lib("common_test/include/ct.hrl").
-include("ssh_test_lib.hrl").

%% Note: This directive should only be used in test suites.
-compile(export_all).

-define(SSH_DEFAULT_PORT, 22).
-define(REKEY_DATA_TMO, 65000).

%%--------------------------------------------------------------------
%% Common Test interface functions -----------------------------------
%%--------------------------------------------------------------------

suite() ->
    [{timetrap,{seconds,60}}].

all() -> 
    case os:find_executable("ssh") of
	false -> 
	    {skip, "openSSH not installed on host"};
	_ ->
	    [{group, erlang_client},
	     {group, erlang_server}
	     ]
    end.

groups() -> 
    [{erlang_client, [], [erlang_shell_client_openssh_server
			 ]},
     {erlang_server, [], [erlang_server_openssh_client_renegotiate,
                          exec_with_io_in_sshc,
                          exec_direct_with_io_in_sshc
			 ]}
    ].

init_per_suite(Config) ->
    ?CHECK_CRYPTO(
       case gen_tcp:connect("localhost", 22, []) of
	   {error,econnrefused} ->
	       {skip,"No openssh deamon (econnrefused)"};
	   _ ->
               ssh_test_lib:openssh_sanity_check(
                 [{ptty_supported, ssh_test_lib:ptty_supported()}
                  | Config]
                )
       end
      ).

end_per_suite(_Config) ->
    ok.

init_per_group(erlang_server, Config) ->
    DataDir = proplists:get_value(data_dir, Config),
    UserDir = proplists:get_value(priv_dir, Config),
    ssh_test_lib:setup_dsa_known_host(DataDir, UserDir),
    ssh_test_lib:setup_rsa_known_host(DataDir, UserDir),
    Config;
init_per_group(erlang_client, Config) ->
    CommonAlgs = ssh_test_lib:algo_intersection(
		   ssh:default_algorithms(),
		   ssh_test_lib:default_algorithms(sshd)),
    [{common_algs,CommonAlgs} | Config];
init_per_group(_, Config) ->
    Config.

end_per_group(erlang_server, Config) ->
    UserDir = proplists:get_value(priv_dir, Config),
    ssh_test_lib:clean_dsa(UserDir),
    ssh_test_lib:clean_rsa(UserDir),
    Config;
end_per_group(_, Config) ->
    Config.


init_per_testcase(erlang_server_openssh_client_renegotiate, Config) ->
    case os:type() of
	{unix,_} -> ssh:start(), Config;
	Type -> {skip, io_lib:format("Unsupported test on ~p",[Type])}
    end;
init_per_testcase(_TestCase, Config) ->
    ssh:start(),
    Config.

end_per_testcase(_TestCase, _Config) ->
    ssh:stop(),
    ok.

%%--------------------------------------------------------------------
%% Test Cases --------------------------------------------------------
%%--------------------------------------------------------------------

erlang_shell_client_openssh_server() ->
    [{doc, "Test that ssh:shell/2 works"}].

erlang_shell_client_openssh_server(Config) when is_list(Config) ->
    process_flag(trap_exit, true),
    IO = ssh_test_lib:start_io_server(),
    Prev = lists:usort(supervisor:which_children(sshc_sup)),
    Shell = ssh_test_lib:start_shell(?SSH_DEFAULT_PORT, IO),
    IO ! {input, self(), "echo Hej\n"},
    case proplists:get_value(ptty_supported, Config) of
        true ->
            ct:log("~p:~p  ptty supported", [?MODULE,?LINE]),
            receive_data("Hej", undefined),
            IO ! {input, self(), "exit\n"},
            receive_logout(),
            receive_normal_exit(Shell),
            %% Check that the connection is closed:
            ct:log("Expects ~p", [Prev]),
            ?wait_match(Prev, lists:usort(supervisor:which_children(sshc_sup)));
        false ->
            ct:log("~p:~p  ptty unsupported", [?MODULE,?LINE]),
            receive_exit(Shell,
                         fun({{badmatch,failure},
                              [{ssh,shell,_,_} | _]}) -> true;
                            (_) ->
                                 false
                         end)
    end.

%%--------------------------------------------------------------------
%% Test that the server could redirect stdin and stdout from/to an
%% OpensSSH client when handling an exec request
exec_with_io_in_sshc(Config) when is_list(Config) ->
    SystemDir = proplists:get_value(data_dir, Config),
    {Pid, Host, Port} = ssh_test_lib:daemon([{system_dir, SystemDir},
                                             {failfun, fun ssh_test_lib:failfun/2}]),
    ct:sleep(500),

    ExecStr = "\"io:read('% ').\"",
    Cmd =  "echo howdy. | " ++ ssh_test_lib:open_sshc_cmd(Host, Port,
                                                          "-x", % Disable X forwarding
                                                          ExecStr),
    ct:pal("Cmd = ~p~n",[Cmd]),
    case os:cmd(Cmd) of
        "% {ok,howdy}" -> ok;
        "{ok,howdy}% " -> ok; % Could happen if the client sends the piped
                              % input before receiving the prompt ("% ").
        Other -> ct:fail("Received ~p",[Other])
    end,
    ssh:stop_daemon(Pid).

%%--------------------------------------------------------------------
%% Test that the server could redirect stdin and stdout from/to an
%% OpensSSH client when handling an direct exec request
exec_direct_with_io_in_sshc(Config) when is_list(Config) ->
    SystemDir = proplists:get_value(data_dir, Config),
    {Pid, Host, Port} = ssh_test_lib:daemon([{system_dir, SystemDir},
                                             {failfun, fun ssh_test_lib:failfun/2},
                                             {exec,{direct,fun(Cmnd) ->
                                                                   {ok,X} = io:read(Cmnd),
                                                                   {ok,{X,lists:reverse(atom_to_list(X))}}
                                                           end}}
                                            ]),
    ct:sleep(500),

    Cmd =  "echo ciao. | " ++ ssh_test_lib:open_sshc_cmd(Host, Port,
                                                         "-x", % Disable X forwarding
                                                         "'? '"),
    ct:pal("Cmd = ~p~n",[Cmd]),
    case os:cmd(Cmd) of
        "? {ciao,\"oaic\"}" -> ok;
        "'? '{ciao,\"oaic\"}" -> ok; % WSL
        "{ciao,\"oaic\"}? " -> ok; % Could happen if the client sends the piped
                                   % input before receiving the prompt ("? ").
        Other -> ct:fail("Received ~p",[Other])
    end,
    ssh:stop_daemon(Pid).

%%--------------------------------------------------------------------
%% Test that the Erlang/OTP server can renegotiate with openSSH
erlang_server_openssh_client_renegotiate(Config) ->
    _PubKeyAlg = ssh_rsa,
    SystemDir = proplists:get_value(data_dir, Config),
    PrivDir = proplists:get_value(priv_dir, Config),
    KnownHosts = filename:join(PrivDir, "known_hosts"),

    {Pid, Host, Port} = ssh_test_lib:daemon([{system_dir, SystemDir},
                                             {failfun, fun ssh_test_lib:failfun/2}]),
    ct:sleep(500),

    RenegLimitK = 3,
    DataFile = filename:join(PrivDir, "renegotiate_openssh_client.data"),
    Data =  lists:duplicate(trunc(1.1*RenegLimitK*1024), $a),
    ok = file:write_file(DataFile, Data),

    Cmd = ssh_test_lib:open_sshc_cmd(Host, Port,
                                     [" -o UserKnownHostsFile=", KnownHosts,
                                      " -o StrictHostKeyChecking=no",
                                      " -o RekeyLimit=",integer_to_list(RenegLimitK),"K"]),


    OpenSsh = ssh_test_lib:open_port({spawn, Cmd++" < "++DataFile}),

    Expect = fun({data,R}) -> 
		     try
			 NonAlphaChars = [C || C<-lists:seq(1,255), 
					       not lists:member(C,lists:seq($a,$z)),
					       not lists:member(C,lists:seq($A,$Z))
					 ],
			 Lines = string:tokens(binary_to_list(R), NonAlphaChars),
			 lists:any(fun(L) -> length(L)>1 andalso lists:prefix(L, Data) end,
				   Lines)
		     catch
			 _:_ -> false
		     end;

		({exit_status,E}) when E=/=0 ->
		     ct:log("exit_status ~p",[E]),
		     throw({skip,"exit status"});

		(_) ->
		     false
	     end,
    
    try 
	ssh_test_lib:rcv_expected(Expect, OpenSsh, ?TIMEOUT)
    of
	_ ->
	    %% Unfortunately we can't check that there has been a renegotiation, just trust OpenSSH.
	    ssh:stop_daemon(Pid)
    catch
	throw:{skip,R} -> {skip,R}
    end.

%%--------------------------------------------------------------------
%%% Internal functions -----------------------------------------------
%%--------------------------------------------------------------------
receive_data(Data, Conn) ->
    receive
	Info when is_binary(Info) ->
	    Lines = string:tokens(binary_to_list(Info), "\r\n "),
	    case lists:member(Data, Lines) of
		true ->
		    ct:log("~p:~p  Expected result ~p found in lines: ~p~n", [?MODULE,?LINE,Data,Lines]),
		    ok;
		false ->
		    ct:log("~p:~p  Extra info: ~p~n", [?MODULE,?LINE,Info]),
		    receive_data(Data, Conn)
	    end;
	Other ->
	    ct:log("~p:~p  Unexpected: ~p",[?MODULE,?LINE,Other]),
	    receive_data(Data, Conn)
    after
	30000 ->
             {State, _} = case Conn of
                              undefined -> {'??','??'};
                              _ -> sys:get_state(Conn)
                          end,
            ct:log("timeout ~p:~p~nExpect ~p~nState = ~p",[?MODULE,?LINE,Data,State]),
            ct:fail("timeout ~p:~p",[?MODULE,?LINE])
    end.	

receive_logout() ->
    receive
	<<"logout">> ->
	    extra_logout(),
	    receive
		<<"Connection closed">> ->
		    ok
	    after 
		30000 -> ct:fail("timeout ~p:~p",[?MODULE,?LINE])
	    end;
	Info ->
	    ct:log("Extra info when logging out: ~p~n", [Info]),
	    receive_logout()
    after 
	30000 -> ct:fail("timeout ~p:~p",[?MODULE,?LINE])
    end.


receive_normal_exit(Shell) ->
    receive_exit(Shell, fun(Reason) -> Reason == normal end).


receive_exit(Shell, F) when is_function(F,1) ->
    receive
        {'EXIT', Shell, Reason} ->
            case F(Reason) of
                true ->
                    ok;
                false ->
                    ct:fail({unexpected_exit, Reason})
            end;

        <<"\r\n">> ->
            receive_normal_exit(Shell);

        Other ->
            ct:fail({unexpected_msg, Other})

        after 
	30000 -> ct:fail("timeout ~p:~p",[?MODULE,?LINE])
    end.


extra_logout() ->
    receive 	
	<<"logout">> ->
	    ok
    after 500 -> 
	    ok
    end.

%%--------------------------------------------------------------------
%% Check if we have a "newer" ssh client that supports these test cases
check_ssh_client_support(Config) ->
    case ssh_test_lib:ssh_client_supports_Q() of
	true ->
	    ssh:start(),
	    Config;
	_ ->
	    {skip, "test case not supported by ssh client"}
    end.

comment(AtomList) ->
    ct:comment(
      string:join(lists:map(fun erlang:atom_to_list/1, AtomList),
		", ")).

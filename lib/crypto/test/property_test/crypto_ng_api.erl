%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 2004-2020. All Rights Reserved.
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

-module(crypto_ng_api).

-compile(export_all).

-include_lib("common_test/include/ct_property_test.hrl").

-include("crypto_prop_generators.hrl").

%%%================================================================
%%% Properties:

prop__crypto_one_time() ->
    numtests(10000,
             ?FORALL({TextPlain, Cipher, Key, IV}, ?LET(Ciph,cipher(),
                                                        {text_plain(), Ciph, key(Ciph), iv(Ciph)}),
                     begin
                         R = equal(TextPlain,
                                   full_blocks(TextPlain, Cipher),
                                   decrypt_encrypt_one_time(Cipher, Key, IV, TextPlain)),
                         prt_inf(Cipher, TextPlain, R)
                     end
                    )
            ).

prop__crypto_init_update() ->
    numtests(10000,
             ?FORALL({TextPlain, Cipher, Key, IV}, ?LET(Ciph,cipher(),
                                                                 {text_plain(), Ciph, key(Ciph), iv(Ciph)}),
                     begin
                         R = equal(TextPlain,
                                   full_blocks(TextPlain, Cipher),
                                   decrypt_encrypt_init_update(Cipher, Key, IV, TextPlain)),
                         prt_inf(Cipher, TextPlain, R)
                     end)
            ).

prt_inf(Cipher, TextPlain, R) ->
    aggregate(ct_property_test:title("text lengths",
                                     ct_property_test:print_frequency_ranges(),
                                     fun ct:pal/2),
              [iolist_size(TextPlain)],
    aggregate(ct_property_test:title("ciphers",
                                     ct_property_test:print_frequency(),
                                     fun ct:pal/2),
              [Cipher],
   R)).

%%%================================================================
%%% Lib

equal(_, T, T) -> true;
equal(F, Tp, Td) ->
    ct:pal("Full:  ~p~n"
           "Block: ~p~n"
           "Decr:  ~p~n",
           [F, Tp, Td]),
    false.


decrypt_encrypt_one_time(Cipher, Key, IV, TextPlain) ->
    io:format("~p:~p Cipher: ~p, BlockSize: ~p, Key: ~p, IV: ~p, TextPlain: ~p (~p chunks)",
              [?MODULE,?LINE, Cipher, block_size(Cipher), size(Key), size(IV), size(iolist_to_binary(TextPlain)),
               num_chunks(TextPlain)]),
    TextCrypto = crypto:crypto_one_time(Cipher, Key, IV, TextPlain, true),
    io:format("~p:~p TextCrypto: ~p", [?MODULE,?LINE, size(TextCrypto)]),
    TextDecrypt = crypto:crypto_one_time(Cipher, Key, IV, TextCrypto, false),
    io:format("~p:~p TextDecrypt: ~p", [?MODULE,?LINE, size(TextDecrypt)]),
    TextDecrypt.


decrypt_encrypt_init_update(Cipher, Key, IV, TextPlain) when is_binary(TextPlain) ->
    decrypt_encrypt_init_update(Cipher, Key, IV, [TextPlain]);

decrypt_encrypt_init_update(Cipher, Key, IV, TextPlain) ->
    io:format("~p:~p Cipher: ~p, BlockSize: ~p, Key: ~p, IV: ~p, TextPlain: ~p (~p chunks)",
              [?MODULE,?LINE, Cipher, block_size(Cipher), size(Key), size(IV), size(iolist_to_binary(TextPlain)),
               num_chunks(TextPlain)]),
    Cenc = crypto:crypto_init(Cipher, Key, IV, true),
    TextOut = lists:foldl(fun(TextIn, TextOutAcc) ->
                                  [crypto:crypto_update(Cenc,TextIn) | TextOutAcc]
                          end, [], TextPlain),
    TextCrypto = lists:reverse(TextOut),
    io:format("~p:~p TextCrypto: ~p",
              [?MODULE,?LINE, size(iolist_to_binary(TextCrypto))]),
    
    Cdec = crypto:crypto_init(Cipher, Key, IV, false),
    TextDec = lists:foldl(fun(TextC, TextDecAcc) ->
                                  [crypto:crypto_update(Cdec,TextC) | TextDecAcc]
                          end, [], TextCrypto),
    iolist_to_binary(lists:reverse(TextDec)).

full_blocks(TextPlain, Cipher) ->
    TextPlainBin = iolist_to_binary(TextPlain),
    {Head,_Tail} = split_binary(TextPlainBin, (size(TextPlainBin) - num_rest_bytes(TextPlainBin,Cipher))),
    Head.

num_chunks(B) when is_binary(B) -> 1;
num_chunks(L) when is_list(L) -> length(L).

num_rest_bytes(Bin, Cipher) -> size(Bin) rem block_size(Cipher).


%% @author Maas-Maarten Zeeman <mmzeeman@xs4all.nl>
%% @copyright 2022 Maas-Maarten Zeeman
%% @doc Drakon Model.

%% Copyright 2022 Maas-Maarten Zeeman
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


-module(m_drakon).
-author("Maas-Maarten Zeeman <mmzeeman@xs4all.nl>").

-behaviour(zotonic_model).

-include_lib("zotonic_core/include/zotonic.hrl").

-export([
    m_get/3,
    m_post/3
]).

%% #{<<"1">> => #{type => <<"end">>},
%%  <<"2">> =>
%%      #{branchId => 0,one => <<"1">>,type => <<"branch">>}}

m_get([Rsc, <<"diagram">> | Rest], _Msg, Context) ->
    case m_rsc:rid(Rsc, Context) of
        undefined ->
            {error, not_found};
        Id ->
            DiagramItems = case m_rsc:p(Id, diagram_items, Context) of
                               undefined ->
                                   #{};
                               Items ->
                                   Items
                           end,
            Diagram = #{
                        <<"id">> => Id,
                        <<"name">> => z_trans:trans(m_rsc:p_no_acl(Id, title, Context), Context),
                        <<"items">> => DiagramItems
                       },
            Diagram1 = case m_rsc:p_no_acl(Id, diagram_params, Context) of
                           undefined -> Diagram;
                           Params -> Diagram#{ <<"params">> => Params }
                       end,
            DiagramJSON = jsx:encode(Diagram1),

            {ok, {DiagramJSON, Rest}}
    end;

m_get(V, _Msg, _Context) ->
    lager:info("Unknown ~p lookup: ~p", [?MODULE, V]),
    {error, unknown_path}.

m_post([<<"edit">>], #{ payload := #{ <<"changes">> := Changes,
                                      <<"id">> := DiagramId }
                      }, Context) ->

    F = fun(Ctx) ->
                Items = case m_rsc:p_no_acl(DiagramId, diagram_items, Context) of
                            undefined -> #{};
                            M when is_map(M) -> M
                        end,
                Items1 = changes(DiagramId, Changes, Items, Ctx),
                {ok, _} = m_rsc:update(DiagramId, #{ diagram_items => Items1 }, Context),
                ok
        end,
    ok = z_db:transaction(F, Context),
    ok;
m_post(Topic, Msg, _Context) ->
    ?DEBUG({Topic, Msg}),
    ok.


changes(_Id, [], Items, _Context) ->
    Items;
changes(Id, [ Change | Rest], Items, Context) ->
    Items1 = do_change(Id, Change, Items, Context),
    changes(Id, Rest, Items1, Context).

do_change(_Id, #{ <<"op">> := <<"delete">>, <<"id">> := ItemId }, Items, _Context) ->
    maps:remove(ItemId, Items);
do_change(_Id, #{ <<"op">> := <<"insert">>, <<"id">> := ItemId, <<"fields">> := Fields }, Items, _Context) ->
    maps:put(ItemId, Fields, Items);

do_change(_Id, #{ <<"op">> := <<"update">>, <<"id">> := ItemId, <<"fields">> := Fields }, Items, _Context) ->
    Item = maps:get(ItemId, Items),
    Item1 = maps:fold(fun(Key, Value, I) ->
                              maps:put(Key, Value, I)
                      end, Item, Fields),
    maps:update(ItemId, Item1, Items);

do_change(Id, #{ <<"op">> := <<"update">>, <<"fields">> := Fields }, Items, Context) ->
    %% Name update
    Props = case maps:get(<<"name">>, Fields, undefined) of
                 undefined ->
                     #{};
                 Name ->
                     #{ title => Name }
             end,

    %% Field updates
    {ok, _} = m_rsc:update(Id, Props, Context),

    Items.


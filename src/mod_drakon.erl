%% @author Maas-Maarten Zeeman <mmzeeman@xs4all.nl>
%% @copyright 2022 Maas-Maarten Zeeman
%% @doc Provides drakon for Zotonic.

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

-module(mod_drakon).
-mod_title("Drakon Diagrams").
-mod_description("Provides possibility to add drakon diagrams to your site.").
-mod_provides([drakon]).
-mod_depends([base, mod_mqtt]).


-include_lib("zotonic_core/include/zotonic.hrl").

-export([
    init/1,
    event/2,

    update_datamodel/1
]).


init(Context) ->
    update_datamodel(Context),

    ok.

event(#submit{message={edit_content, Args}}, Context) ->
    {id, ItemId} = proplists:lookup(id, Args),
    Content = z_context:get_q(<<"content">>, Context),
    Context1 = z_render:wire({publish, [ {topic, ["model", "drakon", "post", ItemId, "set", "content"]},
                                         {content, Content} ]},
                             Context),
    z_render:wire(lists:flatten(proplists:get_all_values(on_success, Args)), Context1);

event(#submit{message={edit_secondary, Args}}, Context) ->
    {id, ItemId} = proplists:lookup(id, Args),
    Secondary = z_context:get_q(<<"secondary">>, Context),
    Context1 = z_render:wire({publish, [ {topic, ["model", "drakon", "post", ItemId, "set", "secondary"]},
                                         {secondary, Secondary} ]},
                             Context),
    z_render:wire(lists:flatten(proplists:get_all_values(on_success, Args)), Context1);

event(#submit{message={edit_link, Args}}, Context) ->
    {id, ItemId} = proplists:lookup(id, Args),
    Link = z_context:get_q(<<"link">>, Context),
    Context1 = z_render:wire({publish, [ {topic, ["model", "drakon", "post", ItemId, "set", "link"]},
                                         {link, Link} ]},
                             Context),
    z_render:wire(lists:flatten(proplists:get_all_values(on_success, Args)), Context1).

%%
%% Helpers
%%


update_datamodel(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context).

datamodel() ->
    #datamodel{
       categories = [
                     {drakon_diagram, undefined, [{title, <<"Drakon Diagram">>}]}
                    ]
      }.


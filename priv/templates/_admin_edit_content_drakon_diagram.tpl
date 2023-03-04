{% extends "admin_edit_widget_std.tpl" %}

{% block widget_title %}
{_ Diagram _}
<div class="widget-header-tools"></div>
{% endblock %}

{% block widget_show_minimized %}false{% endblock %}

{% block widget_content %}

<div class="container-fluid" role="menubar">
    <ul class="nav navbar-nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                {_ Edit  _}
            </a>

            <ul class="dropdown-menu">
            </ul>
        </li>

        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                {_ Format _}
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" data-onclick-topic="model/drakon/post/toggleSilhouette">Toggle Silhouette</a></li>
                <li><a class="dropdown-item" data-onclick-topic="model/drakon/post/swapYesNo">Swap "Yes" and "No"</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" data-onclick-topic="model/drakon/post/---">Icon Style</a></li>
                <li><a class="dropdown-item" data-onclick-topic="model/drakon/post/---">Font</a></li>
                <li><a class="dropdown-item" data-onclick-topic="model/drakon/post/---">Font Size</a></li>
            </ul>
        </li>
    </ul>
</div>

<div class="container-fluid" role="menubar">
    <ul class="nav navbar-nav">
        <div class="btn-group" role="group">
            {# action question select case foreach branch insertion comment parblock par timer pause duration shelf process input output ctrlstart ctrlend #}

            {% include "_insert_button.tpl" type="action"    icon="action.png"   text=_"Action"   shortcut="a" %}
            {% include "_insert_button.tpl" type="question"  icon="question.png" text=_"Question" shortcut="q" %}
            {% include "_insert_button.tpl" type="select"    icon="select.png"   text=_"Select"   shortcut="s" %}
            {% include "_insert_button.tpl" type="case"      icon="case.png"     text=_"Case"     shortcut="c" %}

            {% include "_insert_button.tpl" type="foreach"   icon="foreach.png"   text=_"Foreach"   shortcut="l" %}
            {% include "_insert_button.tpl" type="branch"    icon="branch.png"    text=_"Branch"    shortcut="b" %}
            {% include "_insert_button.tpl" type="insertion" icon="insertion.png" text=_"Insertion" shortcut="n" %}
            {% include "_insert_button.tpl" type="comment"   icon="comment.png"   text=_"Comment" %}

            {% include "_insert_button.tpl" type="simpleinput"  icon="sinput.png" text=_"Simple Input" %}
            {% include "_insert_button.tpl" type="simpleoutput" icon="soutput.png" text=_"Simple Output" %}
        </div>

        <div class="btn-group ms-1" role="group">
            {% include "_insert_button.tpl" type="parblock"  icon="parblock.png" text=_"Parblock" %}
            {% include "_insert_button.tpl" type="par"       icon="par.png" text=_"Par" %}
        </div>

        <div class="btn-group ms-1" role="group">
            {% include "_insert_button.tpl" type="timer"     icon="timer.png" text=_"Timer" %}
            {% include "_insert_button.tpl" type="pause"     icon="pause.png" text=_"Pause" %}
            {% include "_insert_button.tpl" type="duration"  icon="duration.png" text=_"Duration" %}
        </div>

        <div class="btn-group ms-1" role="group">
            {% include "_insert_button.tpl" type="shelf"     icon="shelf.png" text=_"Shelf" %}
            {% include "_insert_button.tpl" type="process"   icon="process.png" text=_"Process" %}
            {% include "_insert_button.tpl" type="input"     icon="input.png" text=_"Input" %}
            {% include "_insert_button.tpl" type="output"    icon="output.png" text=_"Output" %}
        </div>

        <div class="btn-group ms-1" role="group" >
            {% include "_insert_button.tpl" type="ctrlstart" icon="ctrl-start.png" text=_"CTRL Start" %}
            {% include "_insert_button.tpl" type="ctrlend"   icon="ctrl-end.png" text=_"CTRL End" %}
        </div>

    </ul>
</div>

<div id="editor-area" style="height: 300px;">
</div>

{# [TODO] ombouwen naar normale modal options #}

{% wire name="edit_content"   action={dialog_open title=_"Edit" template="_modal_edit_content.tpl"   on_success={b5_modal_hide}} %}
{% wire name="edit_link"      action={dialog_open title=_"Edit Link" template="_modal_edit_link.tpl"      on_success={b5_modal_hide}} %}
{% wire name="edit_secondary" action={dialog_open title=_"Edit Secondary" template="_modal_edit_secondary.tpl" on_success={b5_modal_hide}} %}

{% lib "js/drakonwidget.js"
       "js/mousetrap.min.js"
%}

{% javascript %}
let drakon = createDrakonWidget();
let currentSelection;

function startEditContent(item, isReadonly) {
    z_event("edit_content", item)
}

function startEditSecondary(item, isReadonly) {
    z_event("edit_secondary", item)
}

function startEditLink(item, isReadonly) {
    z_event("edit_link", item)
}

function showMyCuteContextMenu(left, top, items) {
    console.log("context", left, top, items)
}

function selectionChanged(items) {
    currentSelection = items;
}

function buildConfig() {
    var config = {}

    config.startEditContent = startEditContent
    config.startEditSecondary = startEditSecondary;
    config.startEditLink = startEditLink;

    config.allowResize = true;

    config.showContextMenu = showMyCuteContextMenu;

    config.onSelectionChanged = selectionChanged;

    config.drawZones = false;
    config.canSelect = true;
    config.maxWidth = 300;

    config.theme = {
        lineWidth: 2,

        background: "#fffdf5",

        iconBorder: "black",
        iconBack: "white",


        branch: "{_ Branch _}",
        end: "{_ End _}",
        yes: "{_ Yes _}",
        no: "{_ No _}",
        exit: "{_ Exit _}"
    }

    return config
}

function rebuildWidgetElement() {
    const editorArea = document.getElementById("editor-area");
    
    const rect = editorArea.getBoundingClientRect();
    const config = buildConfig()

    editorArea.innerHTML = ""

    const widgetElement = drakon.render(rect.width, rect.height, config)

    editorArea.appendChild(widgetElement);
}

function createEditSender() {
    return {
        stop: function () {
            console.log("stop");
        },

        pushEdit: function(edit) {
            console.log("pushEdit", edit)
            cotonic.broker.publish("bridge/origin/model/drakon/post/edit", edit, {qos: 1});
        }
    }
}

rebuildWidgetElement();

drakon.setDiagram("1886", JSON.parse('{{ m.drakon[1886].diagram }}'), createEditSender()); 

function init() {
    console.log("init");
    console.log(drakon);
    cotonic.broker.subscribe(
        "model/drakon/post/+action",
        function(m, b) {
            console.log(b.action);
            switch(b.action) {
            case "edit":
                drakon.editContent();
                break;
            case "toggleSilhouette":
                drakon.toggleSilhouette();
                break;
            case "swapYesNo":
                console.log(drakon);
                console.log("selection", drakon.selection);
                if(currentSelection.length > 0 && currentSelection[0].type === "question") {
                    for(let i=0; i<currentSelection.length; i++) {
                        if(currentSelection[0].type === "question") {
                            drakon.swapYesNo(currentSelection[0].id);
                        }
                    }
                }
                break;
            case "undo":
                drakon.undo();
                break;
            case "redo":
                drakon.redo();
                break;
            case "delete":
                drakon.deleteSelection();
                break;
            case "cut":
                drakon.cutSelection();
                break;
            case "copy":
                drakon.copySelection();
                break;
            case "paste":
                drakon.pasteSelection();
                break;
            case "up":
                drakon.arrowUp();
                break;
            case "right":
                drakon.arrowRight();
                break;
            case "down":
                drakon.arrowDown();
                break;
            case "left":
                drakon.arrowLeft();
                break;
            default:
                console.warn("Unknown action", b);
            }
        }
    )

    cotonic.broker.subscribe(
        "model/drakon/post/insert/+type",
        function(m, b) {
            drakon.showInsertionSockets(b.type);
        }
    )  

    cotonic.broker.subscribe(
        "model/drakon/post/+id/set/+what",
        function(m, b) {
            switch(b.what) {
            case "content":
                drakon.setContent(b.id, m.payload.content);
                break;
            case "secondary":
                drakon.setSecondary(b.id, m.payload.secondary);
                break;
            case "link":
                drakon.setLink(b.id, m.payload.link);
                break;
            case "zoom":
                drakon.setZoom(b.id, m.payload.zoomLevel);
                break;
            }
        }
    )
}

cotonic.ready.then(init);

{% endjavascript %}

{% endblock %}


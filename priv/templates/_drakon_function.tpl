{% if text %}
    <a class="dropdown-item" data-onclick-topic="model/drakon/post/{{ function }}">{{ text }}</a>
{% endif %}
{% if shortcut %}{% javascript %}
    Mousetrap.bind('{{ shortcut }}', function(e) { e.preventDefault(); cotonic.broker.publish("model/drakon/post/{{ function }}") } );
{% endjavascript %}{% endif %}

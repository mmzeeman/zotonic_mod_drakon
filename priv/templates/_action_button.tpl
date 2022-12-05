<button class="btn btn-light" data-onclick-topic="model/drakon/post/{{ type }}">{{ text }}</button>
{% if shortcut %}{% javascript %}
    Mousetrap.bind('{{ shortcut }}', function(e) { e.preventDefault(); cotonic.broker.publish("model/drakon/post/{{ type }}") } );
{% endjavascript %}{% endif %}

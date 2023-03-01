<button style="height: 34px; width: 34px; padding: 0px 5px" class="btn btn-default" data-onclick-topic="model/drakon/post/insert/{{ type }}">
    <img src="/lib/images/icons/{{ icon }}" alt="{{ text }}" class="img-fluid" style="filter: grayscale(100%);" />
</button>
{% if shortcut %}{% javascript %}
    Mousetrap.bind('{{ shortcut }}', function() { cotonic.broker.publish("model/drakon/post/insert/{{ type }}") } );
{% endjavascript %}{% endif %}

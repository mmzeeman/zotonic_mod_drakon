<button style="height: 32px; width: 32px; " class="btn p-1 btn-sm btn-outline-light" data-onclick-topic="model/drakon/post/insert/{{ type }}">
    <img src="/lib/images/icons/{{ icon }}" alt="{{ text }}" class="img-fluid" style="filter: grayscale(100%); " />
</button>
{% if shortcut %}{% javascript %}
    Mousetrap.bind('{{ shortcut }}', function() { cotonic.broker.publish("model/drakon/post/insert/{{ type }}") } );
{% endjavascript %}{% endif %}

{% extends "base_noscript.tpl" %}

{% block _html_head %}
  {% all include "_html_head.tpl" %}
  {% lib
      "bootstrap-5/css/bootstrap.min.css"
      "css/jquery.loadmask.css"
      "css/z.growl.css"
      "css/z.modal.css"
  %}
  {% block html_head_extra %}
  {% endblock %}
{% endblock %}

{% block _js_include %}
  {% include "_js_include.tpl" %}
  {% lib "bootstrap-5/js/bootstrap.bundle.min.js"
         "js/b5_modal.js"
  %}
  {% script %}
{% endblock%}

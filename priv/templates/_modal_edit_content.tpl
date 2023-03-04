{% wire id="edit_content" type="submit" postback={edit_content id=q.id on_success=on_success} delegate=`mod_drakon` %}  
<form id="edit_content" class="flex-fill" method="post" action="postback">
    <textarea name="content" class="form-control" autofocus>{{ q.content | escape }}</textarea>
</form>

<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{_ Close _}</button>
{% button class="btn btn-primary" text=_"Save changes" action={submit target="edit_content"} %}

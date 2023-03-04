{% wire id="edit_secondary" type="submit" postback={edit_secondary id=q.id on_success=on_success} delegate=`mod_drakon` %}  
<form id="edit_secondary" class="flex-fill" method="post" action="postback">
    <textarea name="secondary" class="form-control" autofocus>{{ q.secondary | escape }}</textarea>
</form>

<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{_ Close _}</button>
{% button class="btn btn-primary" text=_"Save changes" action={submit target="edit_secondary"} %}


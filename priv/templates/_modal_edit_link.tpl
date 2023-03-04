{% wire id="edit_link" type="submit" postback={edit_link id=q.id on_success=on_success} delegate=`mod_drakon` %}  
<form id="edit_link" class="flex-fill" method="post" action="postback">
    <textarea name="link" class="form-control" autofocus>{{ q.link | escape }}</textarea>
</form>

<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{_ Close _}</button>
{% button class="btn btn-primary" text=_"Save changes" action={submit target="edit_icon_content"} %}


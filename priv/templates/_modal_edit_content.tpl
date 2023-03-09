{% wire id=#edit_content type="submit" postback={edit_content id=q.id on_success=on_success} delegate=`mod_drakon` %}  
<form id="{{ #edit_content }}" class="flex-fill" method="post" action="postback">
    <textarea name="content" class="do_autofocus form-control">{{ q.content | escape }}</textarea>
</form>

<div class="modal-footer clearfix">
    {% button class="btn btn-default" action={dialog_close} text=_"Close" tag="a" %}
    {% button class="btn btn-primary" text=_"Save Changes" action={submit target=#edit_content} %}
</div>


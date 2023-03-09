{% wire id=#edit_secondary type="submit" postback={edit_secondary id=q.id on_success=on_success} delegate=`mod_drakon` %}  
<form id="{{ #edit_secondary }}" class="flex-fill" method="post" action="postback">
    <textarea name="secondary" class="do_autofocus form-control">{{ q.secondary | escape }}</textarea>
</form>

<div class="modal-footer clearfix">
    {% button class="btn btn-default" action={dialog_close} text=_"Close" tag="a" %}
    {% button class="btn btn-primary" text=_"Save Changes" action={submit target=#edit_secondary} %}
</div>


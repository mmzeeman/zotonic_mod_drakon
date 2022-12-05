<div class="modal" tabindex="-1">
    <div class="modal-dialog modal-fullscreen-md-down">
        <div class="modal-content bg-white shadow-lg border-0">

            <div class="modal-header d-flex justify-content-between align-items-center border-0">
                <h5 class="modal-title">{_ Edit Secondary _}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body pt-0">
                {% wire id="edit_secondary" type="submit" postback={edit_secondary id=q.id on_success=on_success} delegate=`mod_drakon` %}  
                <form id="edit_secondary" class="flex-fill" method="post" action="postback">
                    <textarea name="secondary" class="form-control" autofocus>{{ q.secondary | escape }}</textarea>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{_ Close _}</button>
                {% button class="btn btn-primary" text=_"Save changes" action={submit target="edit_secondary"} %}
            </div>

        </div>
    </div>
</div>


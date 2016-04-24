// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('page:change', function() {

  var $fileInput           = $('#note_attachments_');
  var $fileSubmitButton    = $('[id$=NoteForm] :submit');
  var $selectedAttachments = $('#attachments-selected');

  $fileInput.on('change', function() {
    $selectedAttachments.empty();
    var attachments = $fileInput[0].files;
    for (var i = 0; i < attachments.length; i++)
      $selectedAttachments.append('<li><a href="#">' + attachments[i].name + '</a></li>');
  });

  $fileSubmitButton.on('click', function() {
    var attachments = $fileInput[0].files;
    if (attachments.length) { $(this).val($(this).data('submit')); }
    $(this).attr('disabled', 'disabled');
    return true;
  });
});
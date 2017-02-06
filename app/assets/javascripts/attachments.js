// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('page:change', function() {

  var $fileSelect   = $('input:file');
  var $submitButton = $('[id$=NoteForm] :submit');
  var $fileList     = $('#file-list');

  $fileSelect.on('change', function() {
    var files = $fileSelect[0].files;
    var fileNames = $.map(files, function(val) { return '"' + val.name + '"'; });
    $fileList.val(fileNames.join(', '));
  });

  $submitButton.on('click', function() {
    var files = $fileSelect[0].files;
    if (files.length) { $(this).val($(this).data('submit')); }
    $(this).attr('disabled', 'disabled');
    return true;
  });
});
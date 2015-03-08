$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(document).on('click', ".question", function(e){
    e.preventDefault();
    console.log("Clicked new question")
    var form = $(this)
    $.ajax({
      "url": form.attr('action'),
      "method": form.attr('method'),
      "data": form.serialize(),
      "success": function(response){
        // RESPONSE IN JSON survey_questionNUMBER, erb//
        $(".question.last_child").append(response)}

  });

});



});

$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(document).on('click', ".new_question", function(e){
    e.preventDefault();
    console.log("Clicked new question")
    var form = $(this)
    // $.ajax({
    //   "url": form.attr('action'),
    //   "method": form.attr('method'),
    //   "data": form.serialize(),
    //   "success": function(response){
    //     // RESPONSE IN JSON survey_questionNUMBER, erb//
    //     $(response.question_number).append(response.html);
    // });

  });

  $(document).on('click', ".new_answer", function(e){
    e.preventDefault();
    console.log("Clicked new answer")
    var form = $(this)
  //   $.ajax({
  //     "url": form.attr('action'),
  //     "method": form.attr('method'),
  //     "data": form.serialize(),
  //     "success": function(response){
  //       // RESPONSE IN JSON survey_questionNUMBER, erb//
  //       $(response.question_number).append(response.html);
  //   });

  });

});

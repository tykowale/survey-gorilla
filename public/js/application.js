$(document).ready(function(){

  $(document).on("submit", ".question", function(e){
    e.preventDefault();

    var form = $(this)


    $.ajax({
      "url": form.attr('action'),
      "method": form.attr('method'),
      "data": form.serialize(),
      "success": function(response){
        $(".question").replaceWith(response)
      }
    })

  });

});

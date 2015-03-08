$(document).ready(function(){

  $(document).on("submit", ".question", function(e){
    e.preventDefault();
    console.log("Clicked on a question")
  });

});

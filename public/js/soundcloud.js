$(document).ready(function() {
  $('#soundcloudsearch form').on('submit', function(event){
  	event.preventDefault();
  	$.ajax({
  		url: $(this).attr('action'),
  		type: $(this).attr('method'),
  		data: $(this).serialize(),
  		dataType: 'json'
  	})
  	.done(function(response){
      console.log(response)
  		response.forEach(function(sound){
        console.log(sound)
        $("#soundcloud #searchresults").append(sound['permalink_url']);  
      });
  	})
  	.fail(function(response){
  		console.log('FAIL');
  	})
  })
});

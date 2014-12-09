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
  		$("#soundcloud #searchresults").append(response[0]['text']);
  	})
  	.fail(function(response){
  		console.log('FAIL');
  	})
  })
});

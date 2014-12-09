$(document).ready(function() {
  $('#twittersearch form').on('submit', function(event){
  	event.preventDefault();
  	$.ajax({
  		url: $(this).attr('action'),
  		type: $(this).attr('method'),
  		data: $(this).serialize(),
  		dataType: 'json'
  	})
  	.done(function(response){
      console.log(response)
  		$("#twitter #searchresults").append(response[0]['text']);
  	})
  	.fail(function(response){
  		console.log('FAIL');
  	})
  })
});

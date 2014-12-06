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
  		console.log(response);
  	})
  	.fail(function(response){
  		console.log('FAIL');
  	})
  })
});

get '/auth/foursquare/callback' do
	binding.pry
	session[:foursquare] = {info: request.env['omniauth.auth']['info'], credentials: request.env['omniauth.auth']['credentials']}
	redirect '/'
end
get '/auth/foursquare/callback' do
	session[:foursquare] = {info: request.env['omniauth.auth']['info'], credentials: request.env['omniauth.auth']['credentials']}
	redirect '/'
end

get '/foursquare/signout' do
	session[:foursquare] = nil
	redirect '/'
end
get '/auth/twitter/callback' do
	session[:twitter] = {info: request.env['omniauth.auth']['info'],  credentials: request.env['omniauth.auth']['credentials'] }
	redirect '/'
end

get '/twitter/signout' do
	session[:twitter] = nil
	redirect '/'
end
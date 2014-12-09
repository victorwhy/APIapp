get '/auth/soundcloud' do
	client = Soundcloud.new(client_id: ENV['SOUNDCLOUD_KEY'], client_secret: ENV['SOUNDCLOUD_SECRET'], redirect_uri: ENV['SOUNDCLOUD_URI'])
	redirect client.authorize_url()
end

get '/auth/soundcloud/callback' do
	binding.pry
	session[:soundcloud] = {info: request.env['omniauth.auth']['info'], credentials: request.env['omniauth.auth']['credentials']}
	redirect '/'
end

get '/soundcloud/signout' do
	session[:soundcloud] = nil
	redirect '/'
end

post '/soundcloud/search' do
	tweetarray = []
	text = params[:query]
	soundcloudSearch(text).to_json
end

def soundcloudSearch(text)
	binding.pry
	client = Soundcloud.new(client_id: session[:soundcloud][:credentials][:token])
	
	soundcloudarray = []

	client.get('/tracks', q: text).take(10).each do |track|
		soundcloudarray << track
	end

	soundcloudarray

end

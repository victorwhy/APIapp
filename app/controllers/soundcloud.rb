get '/auth/soundcloud' do
	client = Soundcloud.new(client_id: ENV['SOUNDCLOUD_KEY'], client_secret: ENV['SOUNDCLOUD_SECRET'], redirect_uri: ENV['SOUNDCLOUD_URI'], scope: 'non-expiring')
	redirect client.authorize_url()
end

get '/auth/soundcloud/callback' do
	client = Soundcloud.new(client_id: ENV['SOUNDCLOUD_KEY'], client_secret: ENV['SOUNDCLOUD_SECRET'], redirect_uri: ENV['SOUNDCLOUD_URI'], scope: 'non-expiring')
	code = params[:code]
	access_token = client.exchange_token(code: code)
	
	setSoundcloudSession(access_token[:access_token])
	
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

def setSoundcloudSession(access_token)
	client = Soundcloud.new(access_token: access_token)
	client_info = client.get('/me')
	session[:soundcloud] = {
		info: {
				username: client_info['username'],
				name: client_info['full_name'],
				description: client_info['description'],
				location: client_info['city'],
				url: client_info['permalink_url'],
				image: client_info['avatar_url']
			},
		credentials: access_token
	}
end

def soundcloudSearch(text)
	client = Soundcloud.new(access_token: session[:soundcloud][:credentials])
	
	soundcloudarray = []

	client.get('/tracks', q: text).take(10).each do |track|
		soundcloudarray << track
	end

	soundcloudarray

end

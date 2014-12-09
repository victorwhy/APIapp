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

def soundcloudSearch(text)
	binding.pry
	client = Soundcloud.new(client_id: session[:soundcloud][:credentials][:token])
	
	soundcloudarray = []

	client.get('/tracks', q: text).take(10).each do |track|
		soundcloudarray << track
	end

	soundcloudarray

end

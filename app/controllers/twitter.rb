get '/auth/twitter/callback' do
	session[:twitter] = {info: request.env['omniauth.auth']['info'], credentials: request.env['omniauth.auth']['credentials'], client:  setUpTwitter(request.env['omniauth.auth']['credentials'])}
	redirect '/'
end

get '/twitter/signout' do
	session[:twitter] = nil
	redirect '/'
end

post '/twitter/search' do
	tweetarray = []
	client = session[:twitter][:client]
	text = params[:query]
	client.search(text, result_type: "recent").take(10).each do |tweet|
	  tweetarray << tweetParser(tweet)
	end
	binding.pry
	return { hello: 1, no: "tello" }.to_json
end



def setUpTwitter(credentials)
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV['TWITTER_KEY']
	  config.consumer_secret     = ENV['TWITTER_SECRET']
	  config.access_token        = credentials['token']
	  config.access_token_secret = credentials['secret']
	end
	client
end

def tweetParser(tweet)
	parsedTweet = {}
	parsedTweet[:uri] = tweet.uri.to_s
	parsedTweet[:text] = tweet.text
	parsedTweet[:userid] = tweet.user.id
	parsedTweet[:username] = tweet.user.username
	parsedTweet[:created_at] = tweet.created_at
	parsedTweet
end
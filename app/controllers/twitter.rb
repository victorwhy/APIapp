require "sinatra/json"

$client = {}

get '/auth/twitter/callback' do
	session[:twitter] = {info: request.env['omniauth.auth']['info'], credentials: request.env['omniauth.auth']['credentials']}
	$client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV['TWITTER_KEY']
	  config.consumer_secret     = ENV['TWITTER_SECRET']
	  config.access_token        = request.env['omniauth.auth']['credentials']['token']
	  config.access_token_secret = request.env['omniauth.auth']['credentials']['secret']
	end

	binding.pry
	redirect '/'
end

get '/twitter/signout' do
	session[:twitter] = nil
	redirect '/'
end

post '/twitter/search' do
	tweetarray = []
	text = params[:query]
	# client.search(text, result_type: "recent").take(10).each do |tweet|
	#   tweetarray << tweetParser(tweet)
	# end
	# binding.pry
	hello = tweetParser(text).to_json
	
end

def tweetParser(text)
	tweet = $client.search(text, result_type: "recent").take(1)[0].to_json
	parsedTweet = {}
	parsedTweet[:uri] = tweet.uri.to_s
	parsedTweet[:text] = tweet.text
	parsedTweet[:userid] = tweet.user.id
	parsedTweet[:screenname] = tweet.user.screen_name
	parsedTweet[:created_at] = tweet.created_at
	parsedTweet
end
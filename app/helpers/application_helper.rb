module ApplicationHelper

def top_tweeter
	tweets = Tweet.all
	if tweets.length > 0
		user_id = Tweet.all.group_by { |h| h['user_id']}.to_a.max_by {|x| x[1].length}.first
		user = User.find(user_id)
		return user
	end
end

end


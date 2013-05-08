class User

  include HTTParty
  base_uri 'staging.sharepractice.com' #ENV["API_RESOURCE_URL"]

  def initialize(username, password)
    http request ==> name, attributes
    @username = username
    @password = password
    @first_name = 
    @last_name =
    @npi =
    @phone =
    @degree =
    @specialty =
    @website =
    @location =
    @history =
    @verified =
    @avatar_url =
  end

  # def change_attributes(params)
  #   #call frontline
  #   name = name
  # end

  # def follow_user(user_id)
  # end

  # def unfollow_user(user_id)
  # end

  # def delete
  #   call frontline
  # end

  # response = create_user_invite(params)
  # unless response[:success] == "true"
  #   flash.now[:alert] = response[:message]
  #   render :invite
  # end

end

#   def initialize(u, p)
#     @auth = {:username => u, :password => p}
#   end

#   # which can be :friends, :user or :public
#   # options[:query] can be things like since, since_id, count, etc.
#   def timeline(which=:friends, options={})
#     options.merge!({:basic_auth => @auth})
#     self.class.get("/statuses/#{which}_timeline.json", options)
#   end

#   def post(text)
#     options = { :body => {:status => text}, :basic_auth => @auth }
#     self.class.post('/statuses/update.json', options)
#   end
# end

# twitter = Twitter.new(config['email'], config['password'])
# pp twitter.timeline
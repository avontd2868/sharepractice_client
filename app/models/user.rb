class User
  attr_accessible :name, :id

  def initialize(id, params)
    http request ==>name, attributes
    name = name
    other_attribute = 

  end

  def change_attributes(params)
    call frontline
    name = name
  end

  def delete
    call frontline
  end

  # response = create_user_invite(params)
  # unless response[:success] == "true"
  #   flash.now[:alert] = response[:message]
  #   render :invite
  # end

end


class Twitter
  include HTTParty
  base_uri 'twitter.com'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
  end

  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def timeline(which=:friends, options={})
    options.merge!({:basic_auth => @auth})
    self.class.get("/statuses/#{which}_timeline.json", options)
  end

  def post(text)
    options = { :body => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end
end

class UsersController
  def 
twitter = Twitter.new(config['email'], config['password'])
pp twitter.timeline
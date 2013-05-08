require 'httparty'

class User
  include HTTParty
  base_uri 'staging.sharepractice.com'
  default_params :output => 'json'
  format :json

  def initialize(email, password)
    @response = HTTParty.get('/api/v1/tokens?format=json', :query => {:email => email, :password => password})
    @email =      email
    @password =   password
    @first_name = response[:first_name]
    @last_name =  response[:last_name]
  end

  def response
    @response.inspect
  end

  def self.find_by_email(email)
    HTTParty.get('/api/v1/users/', :query => {:email => email})
  end
end

#user = User.new("janet@sharepractice.com", "password")
user = User.find_by_email("janet@sharepractice.com")
puts user.response

    # @npi =        response[:npi]
    # @phone =      response[:phone]
    # @degree =     response[:degree]
    # @specialty =  response[:specialty]
    # @website =    response[:website]
    # @location =   response[:location]
    # @history =    response[:history]
    # @verified =   response[:verified]
    # @avatar_url = response[:avatar_url]

  # def self.find_by_email(email)
  #   get('/api/v1/users/', :query => {:email => email})
  # end

  # def self.find_followers_of(user_id)
  #   get('api/v1/colleagues/followers/', :query => {:id => user_id})
  # end

  # def self.find_following_by(user_id)
  #   get('api/v1/colleagues/following/', :query => {:id => user_id})
  # end

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

# end
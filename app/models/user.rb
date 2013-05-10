#require 'net/https'
require 'httparty'

class User 
  include HTTParty
  base_uri 'localhost:3000'
  default_params :format => 'json'
  format :json

  def initialize(email, api_key)
    @email    = email
    @api_key  = api_key
    @email    = email
    response  = find_by_email(email)
    puts "RESPONSE: ", response
    @first_name = response[:first_name]
    @last_name  =  response[:last_name]
    @npi        = response[:npi]
    @phone      = response[:phone]
    @degree     = response[:degree]
    @specialty  = response[:specialty]
    @website    = response[:website]
    @location   = response[:location]
    @history    = response[:history]
    @verified   = response[:verified]
    @avatar_url = response[:avatar_url]
  end

  def self.login(email, password)
    response = User.post('/api/v1/tokens', :query => {:email => email, :password => password})
    puts "response: #{response}"
    puts "email: #{response["email"]}"
    puts "token: #{response["token"]}"
    User.new(response["email"], response["token"])
  end

  def find_by_email(email)
    resp = User.get('/api/v1/users/activity', :query => {:email => email, :api_key => @api_key})
    puts resp
  end
end

user = User.login("janet@sharepractice.com", "password")
user.find_by_email("janet@sharepractice.com")


# class UserController
#   def show
#     unless response.message = "Could not find user email/password"
#       @user = User.find_by_email()
#     else
#       flash[:alert] = sp_user.handle_response
#     end
#   end
# end

# 1st part
# problem with the connection

# 2nd part
# problem with frontline
# hash:
# success or failure
# message


#SpUser.find_by_email
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
require 'httparty'

class User 
  include HTTParty
  base_uri 'localhost:3000'
  default_params :format => 'json'
  format :json

  attr_accessor :email, :api_key, :id

  def initialize(response)
    @email    = response["email"]
    @api_key  = response["token"]
    @id       = response[:id]
    #puts "API KEY: #{@api_key}"
    #puts "RESPONSE: #{response}"
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

#if it's a server error, will get html response back

  def self.login(email, password)
    response = User.post('/api/v1/tokens', :query => {:email => email, :password => password})
    #puts "LOGIN RESPONSE: #{response}"
    user = User.new(response)
    #puts "USER API KEY: #{@api_key}"
    response = user.find_by_email(user.email, user.api_key)
  end

  def find_by_email(email, api_key)
    resp = User.get('/api/v1/users/activity', :query => {:email => email, :api_key => api_key})
    #puts "FIND BY EMAIL RESPONSE: #{resp}"
  end

  def find_by_id(id, api_key)
    resp = User.get("/api/v1/users/#{id}/", :query => {:api_key => api_key})
    #puts "FIND BY ID RESPONSE: #{resp}"
  end

  # def save(id, api_key, params)
  #   #TODO: look at active record method "save" for models, and make the same
  #   #OR: make the call directly to frontline API
  #   #manage params key:value in query hash
  #   resp = User.put("api/v1/users/#{id}/", :query => {:api_key => api_key})
  #   true
  # end
end

#user = User.login("b@c.com", "password")
#user.find_by_email("janet@sharepractice.com")


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
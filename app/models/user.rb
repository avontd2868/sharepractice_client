require 'httparty'

class User 
  include HTTParty
  base_uri 'staging.sharepractice.com'
  default_params :format => 'json'
  format :json

  #As transition to Rails 4, attr_accessor is removed in favor of user_params in UsersController
  attr_accessor :email, :api_key, :id, :first_name, :last_name, :npi, :phone, :degree, :specialties, :websites, :locations, :history, :verified, :avatar_url

  def initialize(response)
    @email    = response["email"]
    @api_key  = response["token"]
    @id       = response["uid"]
    #are instance variables here remembered when we call User.new?
    #yes, the API key is in the query string
    other_attributes = User.find_by_id(@id, @api_key)
    other = other_attributes["result"]
    @first_name  = other["first_name"]
    @last_name   = other["last_name"]
    #@npi         = other["npi"]
    #@history     = other["history"]
    #@verified    = other["verified"]
    #@phone       = other["profile"]["phone"]
    #@degree      = other["profile"]["degree"]
    #@specialties = other["profile"]["specialties"]
    #@websites    = other["profile"]["urls"]
    #@locations   = other["profile"]["locations"]
    #@avatar_url  = other["profile"]["avatar_url"]
  end

#if it's a server error, will get html response back

  def self.login(email, password)
    response = User.post('/api/v1/tokens', :query => {:email => email, :password => password})
    user = User.new(response)
    user
  end

  def self.find_by_id(id, api_key)
    #can't form request string correctly with user id
    User.get("/api/v1/users/#{id}/", :query => {:api_key => api_key})
  end

  def self.find_disorders(search_term, api_key)
    User.get("/api/v1/disorders/search", :query => {:api_key => api_key, :q => search_term})
  end

  def self.find_a_disorder(code, api_key)
    User.get("/api/v1/disorders/#{code}", :query => {:api_key => api_key})
  end

  def self.find_treatments(search_term, api_key)
    User.get("/api/v1/treatments/search", :query => {:api_key => api_key, :q => search_term})
  end

  def self.find_prescriptions(disorder_code, api_key)
    User.get("/api/v1/prescriptions/#{disorder_code}", :query => {:api_key => api_key})
  end

  def self.new_prescription(params, api_key)
    User.post("/api/v1/prescriptions", :query => {:rx_code => params[:rx_cui],
                                                  :rx_name => params[:rx_name],
                                                  :brand => params[:brand],
                                                  :rx_id => params[:rx_id],
                                                  :dose => params[:dose],
                                                  :dose_high => params[:dose_high],
                                                  :dose_unit => params[:dose_unit],
                                                  :frequency => params[:frequency],
                                                  :frequency_high => params[:frequency_high],
                                                  :frequency_unit => params[:frequency_unit],
                                                  :duration => params[:duration],
                                                  :duration_high => params[:duration_high],
                                                  :duration_unit => params[:duration_unit],
                                                  :route => params[:route],
                                                  :dx_code => params[:dx_code],
                                                  :note => params[:note],
                                                  :api_key => api_key})
  end

  # def self.get_user(id, api_key)
  #   response = User.find_by_id(id, api_key)
  #   user = User.new(response)
  #   user
  # end
  # def self.new_from_web(id, api_key, params)
  #   email            = params[:email]
  #   password         = params[:password]
  #   password_confirm = params[:password_confirmation]
  #   User.put("/api/v1/users/#{id}", :query => {:api_key => api_key, :email => email, :password => password, :password_confirmation => password_confirm})
  # end

  # def self.save_changes(id, api_key, params)
  #   response = User.put("api/v1/users/#{id}/", :query => {:api_key => api_key})
  #   user = User.new(response)
  # end
end

#user = User.login("b@c.com", "password")
#user.find_by_email("janet@sharepractice.com")

# def parse_response(response)
#   user = User.new(response)
#   user
# end

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

  # response = create_user_invite(params)
  # unless response[:success] == "true"
  #   flash.now[:alert] = response[:message]
  #   render :invite
  # end

# end
class SpUser

  Clearance::User
  include HTTParty
  base_uri 'staging.sharepractice.com'
  # if Rails.env == "production"
  #   base_uri 'api.sharepractice.com' #ENV["API_RESOURCE_URL"]
  # elsif Rails.env == "development" 
  #   base_uri 'staging.sharepractice.com'
  # else #test
  #   base_uri 'localhost:3000'
  # end
  default_params :output => 'json'
  format :json
  
  attr_accessible :email, :first_name, :last_name, :npi, :phone, :degree, :specialty, :website, :location, :history, :verified, :avatar_url

  def initialize(email, password)
    response = get('/api/v1/tokens?format=json', :query = {:email => email, :password => password})
    @email =      email
    @password =   password
    @first_name = response[:first_name]
    @last_name =  response[:last_name]
    @npi =        response[:npi]
    @phone =      response[:phone]
    @degree =     response[:degree]
    @specialty =  response[:specialty]
    @website =    response[:website]
    @location =   response[:location]
    @history =    response[:history]
    @verified =   response[:verified]
    @avatar_url = response[:avatar_url]
  end

  def self.find_by_id(id)
    get('/api/v1/users/', :query => {:id => id})
  end

  def self.find_by_email(email)
    get('/api/v1/users/', :query => {:email => email})
  end

  def self.find_followers_of(user_id)
    get('api/v1/colleagues/followers/', :query => {:id => user_id})
  end

  def self.find_following_by(user_id)
    get('api/v1/colleagues/following/', :query => {:id => user_id})
  end
end
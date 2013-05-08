class SpUser
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

  def self.find_by_id(id)
    get('/api/v1/users/', :query => {:id => id})
  end
end
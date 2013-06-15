class CmsController < ApplicationController
  before_filter :require_login
  skip_before_filter :current_user?

  #respond_to :json
  def index
    @api_key = session[:api_key]
    # all_treatments.each do |t|
    #   name = Disorder.find(t.disorder_cui).name[0]
      #increase o[name['str']]["num"] by 1
    # end
    #make http request and return the response from template: admin view
  end
end
class Dx < Solr

  URL = 'http://localhost:8983/solr/disorder'
  #URL = 'http://app1.pinkberry.me:8080/apache-solr-4.0.0-BETA/collection1'
  #URL = 'http://db2.pinkberry.me:8983/solr/disorder'

  # class << self
  #   attr_accessor :solr
  # end

  attr_accessor :codes, :definition, :dx_code, :name, :resource_uri, :id

  def initialize(params)
    client = Solr.new
    client.create(params[:name], params[:definition])
    @name = params[:name]
    @definition = params[:definition]
    @codes = {}
    @dx_code = 
    @resource_uri
    @id
  end

  def self.all
    Solr.new.find('*:*')
  end

  def self.find(query)
    Solr.new.find(query)
  end
end
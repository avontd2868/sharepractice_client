class Dx < Solr

  URL = 'http://localhost:8983/solr/disorder'
  #URL = 'http://app1.pinkberry.me:8080/apache-solr-4.0.0-BETA/collection1'
  #URL = 'http://db2.pinkberry.me:8983/solr/disorder'

  attr_accessor :codes, :definition, :dx_code, :name, :resource_uri, :id

  def initialize(params)
    client = Solr.new
    client.create(params[:name], params[:definition])
    @name = params[:name]
    @definition = params[:definition]
  end

  def self.all
    response = Solr.new.find('*:*')
    all_dxes = response["response"]["docs"]
  end

  def self.find(name)
    Solr.new.find("name:#{name}")
  end

  def self.find_by_id(id)
    response = Solr.new.find("id:#{id}")
    result = response["response"]["docs"].first
  end

  def self.destroy(id)
    response = Solr.new.delete(id)
    result = response
  end
end
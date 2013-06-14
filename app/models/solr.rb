class Solr
  attr_writer :url#, :query
  attr_reader :result
  attr_accessor :save

  def initialize
    #There should have one argument here for URL, based on type of solr: disorder or treatment
    #We don't have it because there was an ArgumentError "wrong number of arguments" despite correctly being called in Dx class, Solr.new(URL)
    #So, URL is set below for disorders for now
    @url = 'http://localhost:8983/solr/disorder'
    #@query = query
    @save = false
    @error = nil
  end

  def find(query)# = @query)
    solr = RSolr.connect :url => @url
    #q = Solr.prepare_query(query)
    response = Solr.ask_solr(solr, query, :true)
    #docs = Solr.check_spelling(solr, response)
    @result = response
  end

  def create(name, definition="no definition entered")
    #if params are all present and valid
      id = 1234567
      code = "FAKECODE" + name.to_s
      solr_label = ["_START_" + definition.to_s]
      solr = RSolr.connect :url => @url
      solr.add ({:id => id, :label => definition, :solr_label => solr_label, :code => code, :type => "Disorder"})
      response = solr.commit
      #if response indicates successful
        @save = true
      #else
        #@error = "Information was not saved. Please check #Solr.create."
      #end
    #else
      #@error = not saved because params are blank or invalid
    #end
  end

  protected

  def custom_id
    num = Random.new
    num.rand(1000000..9999999)
  end

  def self.prepare_query(query)
    new_query = ''
    query.split(' ').each do |s| #for s in query.split ' ' do
      if query.empty?
        new_query = "solr_label:_START_#{s}^2 || label:#{s}" #solr_label: _START_s^2 OR label: s
      else
        new_query += "AND solr_label:#{s}*"
      end
    end
    new_query
  end

  def self.check_spelling(solr, r)
    if spellcheck_suggestions?(r)
      # query again with first suggestion
      query = "label:" + r['spellcheck']['suggestions'][1]['suggestion'][0]
      response = self.ask_solr(solr, query, :false)
    end
    response['response']['docs']
  end

  def self.ask_solr(solr, query, spellcheck)
    fq = { :q => query, :fl => '*,score', :rows => 100, :spellcheck => spellcheck }
    response = solr.get 'select', :params => fq
  end

  def spellcheck_suggestions?(r)
    r['response']['numFound'] == 0 && r['spellcheck']['suggestions'].length > 0
  end
end
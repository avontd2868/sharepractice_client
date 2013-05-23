require 'rsolr'

class Disorder
  #'http://app1.pinkberry.me:8080/apache-solr-4.0.0-BETA/collection1'
  #'http://db2.pinkberry.me:8983/solr/disorder'

  # attr_accessor :url, :query, :result

  # def initialize(url, query=nil)
  #   @url = url
  #   @query = query
  # end

  # def self.find(query=@query)
  #   solr = RSolr.connect :url => @url
  #   q = SpSolr.prepare_query(query)
  #   response = SpSolr.ask_solr(solr, q, :true)
  #   spell_check_response = SpSolr.check_spelling(solr, response)
  #   @result = spell_check_response
  # end

  def initialize(uri)
    @uri = uri
    @solr = RSolr.connect(:url => "http://localhost:8983/solr/#{uri}", :update_format => :json)
  end

  def create(name)
    #if doesn't exist
      id = create_new_id
      code = create_new_code(name)
      @solr.add {:label => name, :id => id, :code => code, :type => "Disorder"}
      @solr.commit
    #else
      #make an error with notice to user "Disorder already exists. Please enter a new disorder name."
    #end
  end

  def find(id)
    response = @solr.get 'select', :params => {:q => "id:#{id}", :wt => :json}
    #valid response for existing object:
    #{"responseHeader":{"status":0,"QTime":0,"params":{"q":"id:213658","wt":"json"}},"response":{"numFound":1,"start":0,"docs":[{"id":213658,"code":"SP6Labyrinthitis0","label":"Labyrinthitis","solr_label":["_START_Labyrinthitis","_START_Labyrinthitides","_START_Labyrinthitis","_START_Otitis Interna","_START_Labyrinthitis, NOS","_START_Labyrinthitis NOS","_START_Labyrinthitis, unspecified","_START_Unspecified labyrinthitis","_START_Inner ear inflammation","_START_Inflammation of the inner ear(s)","_START_labyrinthitis (diagnosis)","_START_Labyrinthitis (disorder)","_START_Labyrinthitis NOS (disorder)","_START_Unspecified labyrinthitis (disorder)","_START_Labyrinthitis, unspecified ear","_START_Labyrinthitis [Disease/Finding]","_START_hyperemia; labyrinth","_START_inflammation; inner ear","_START_inner ear; inflammation","_START_interna; otitis","_START_labyrinth; hyperemia","_START_otitis; interna"],"type":"Disorder","_version_":1428066787804577792}]}}
    #valid response for nonexistent object:
    #{"responseHeader":{"status":0,"QTime":1,"params":{"q":"id:12353525452","wt":"json"}},"response":{"numFound":0,"start":0,"docs":[]}}
  end

  def delete(id)
    #solr = RSolr.connect :url => 'http://localhost:8983/solr/disorder'
    #response = solr.delete_by_id id #'solr/disorder'
    response = @solr.delete_by_id(id)
    @solr.commit
  end

  private

  def create_new_id
    000001
  end

  def create_new_code(name)
    "FAKE" + name.delete(" ")[0..17] + "CODE"
  end
  # protected
  # def self.prepare_query(query)
  #   q = ''
  #   for s in query.split ' ' do
  #     if q.empty? then
  #       q = "solr_label:_START_#{s}^2 || label:#{s}"
  #     else
  #       q = q + "AND solr_label:#{s}*"
  #     end
  #   end
  #   return q
  # end

  # def self.ask_solr(solr, query, spellcheck)
  #   params = { :q => query, :fl => '*,score', :rows => 100, :spellcheck => spellcheck }
  #   response = solr.get 'select', :params => params
  # end

  # def self.check_spelling(solr, r)
  #   if r['response']['numFound'] == 0 and r['spellcheck']['suggestions'].length > 0 then
  #     # query again with first suggestion
  #     q = "label:" + r['spellcheck']['suggestions'][1]['suggestion'][0]
  #     r = self.ask_solr(solr, q, :false)
  #   end
  #   return r['response']['docs']
  # end
end

#response = Disorder.create('new treatment')
disorder = Disorder.new('/disorder')
response = disorder.create('sample test disorder name')
#response = disorder.delete(210185)
response = disorder.find(210185)
puts response
#response.response.docs.each do |disorder|
#   disorder.id #210304
#   disorder.code #"SP6Cervicocranialsynd0"
#   disorder.label #"Cervicocranial syndrome"
#   disorder.type #"Disorder"
#   disorder.solr_label
# [
#           "_START_Cervicocranial syndrome",
#           "_START_Cervicocranial syndrome",
#           "_START_Cervicocranial syndrome (disorder)",
#           "_START_cervicocranial; syndrome",
#           "_START_syndrome; cervicocranial"
#         ]









class Dx < ActiveRecord::Base

  class << self
    attr_accessor :base_uri
  end

  attr_accessor :codes, :definition, :dx_code, :name, :resource_uri, :id

  def self.find_by_name

  end
end

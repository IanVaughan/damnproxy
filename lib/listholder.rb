require 'yaml'

class ListHolder

  attr_reader :yml

  def initialize(file)
    @yml = []
    @yml = YAML.load_file(file) if File.exist?(file)
  end

  def add url
    @yml << { :site => "#{url}" }
  end

  def edit url, to
    delete url
    add to
  end

  def delete url
    @yml.delete_if { |pack| pack == { site: "#{url}" } }
  end

end

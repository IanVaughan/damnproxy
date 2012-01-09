require 'yaml'

class ListHolder

  attr_reader :yml

  def initialize(file)
    @file = file
    @yml = []
    @yml = YAML.load_file(file) if File.exist?(file)
  end

  def add (*url)

    url.each do |e|
      @yml << { :site => "#{e}" } if e.class == String
    end if url.class == Array
    @yml.flatten!

    #@yml << { :site => "#{url}" } if url.class == String
    save
  end

  def edit url, to
    delete url
    add to
  end

  def delete url
    @yml.delete_if { |pack| pack == { site: "#{url}" } }
    save
  end

  def clear
    @yml.clear
    save
  end

  def save
    File.open(@file, 'w' ) { |f| YAML.dump(@yml, f) }
  end

  def each_url &block
    @yml
  end

end

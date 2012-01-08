require 'yaml'

class ListHolder

  attr_reader :list

  def initialize(file)
    @list = []
    #@yml = YAML.load(file)
  end

  def add url
    @list << url
    #@yml[:site] = url
  end

  def edit url, to
    delete url
    add to
  end

  def delete url
    @list.delete(url)
  end

end

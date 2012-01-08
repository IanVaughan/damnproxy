class ListHolder

  attr_reader :list

  def initialize
    @list = []
  end

  def add url
    @list << url
  end

  def edit url, to
    delete url
    add to
  end

  def delete url
    @list.delete(url)
  end

end

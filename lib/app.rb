require 'listholder'
require 'proxychecker'

class App
  def initialize
    @lh = ListHolder.new('sites.yaml')
  end

  def self.go
    @lh.yml.each
    ProxyChecker.blocked?
  end
end

require 'proxychecker'

describe ProxyChecker do

  it "gets valid response for site that's allowed" do
    Net::HTTP.stub!(:get).and_return('')
    ProxyChecker.blocked?('www.google.com').should eq true
  end

  it "gets blocked from a site that is blocked" do
    Net::HTTP.stub!(:get).and_return('blocked')
    ProxyChecker.blocked?('www.google.com').should eq false
  end

end

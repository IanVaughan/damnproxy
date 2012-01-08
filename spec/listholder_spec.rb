require 'listholder'
#require 'fakefs'
require 'fakefs/safe'

describe ListHolder do

  before(:each) do

    #FakeFS.activate!

    config =
"site: www.google.com
"
    #File.open('config.yml', 'w') {|f| f.write(config) }

    @lh = ListHolder.new(config)
    @lh.add('www.google.com')
  end
  #  let(:lh) {ListHolder.new}

  after(:each) do
    #FakeFS.deactivate!
  end

  it "save new url to list and file" do
    @lh.list.should eq ['www.google.com']
  end

  it "edits url from list/file" do
    @lh.edit('www.google.com', 'www.google.co.uk')
    @lh.list.should eq ['www.google.co.uk']
  end

  it "deletes a url from list/file" do
    @lh.delete('www.google.com')
    @lh.list.should eq []
  end
end

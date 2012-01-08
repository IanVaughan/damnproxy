require 'listholder'

describe ListHolder do

  before do
    @lh = ListHolder.new
  end

  it "save new url to list and file" do
    @lh.add('www.google.com')
    @lh.list.should eq ['www.google.com']
  end

  it "edits url from list/file" do
    @lh.add('www.google.com')
    @lh.edit('www.google.com', 'www.google.co.uk')
    @lh.list.should eq ['www.google.co.uk']
  end

  it "deletes a url from list/file" do
    @lh.add('www.google.com')
    @lh.delete('www.google.com')
    @lh.list.should eq []
  end
end

require 'listholder'
require 'fakefs/safe'

describe ListHolder do
  before(:each) do
    #@lh = ListHolder.new(File.open('config.yml'))
    @lh = ListHolder.new('config.yml')
  end

  context "with no data file" do
    it "saves a new url to list and file" do
      site = 'www.google.com'
      expected_data = [{ :site => "#{site}" }]
      @lh.add site
      @lh.yml.should eq expected_data
    end
  end

  context "with an existing data file" do

    before(:each) do
      # Without FakeFS, autotest just loops!
      FakeFS.activate!

      config =
"-
    :site: www.google.com
"
      File.open('config.yml', 'w') {|f| f.write(config) }

      @expected_data = [{ :site => 'www.google.com' }]

      #@lh = ListHolder.new(config)
      #@lh = ListHolder.new(File.open('config.yml'))
      @lh = ListHolder.new('config.yml')
    end

    after(:each) do
      FakeFS.deactivate!
    end

    it "loads url from file" do
      @lh.yml.should eq @expected_data
    end

    it "save new url to list and file" do
      data = [{ :site => 'www.google.com' }]
      site = 'www.google.com'
      expected_data = [{ :site => "#{site}" }]

      @lh.yml.should eq expected_data
      @lh.yml.should eq data
    end

    it "save another new url to list and file" do
      new_url = 'www.foo.com'
      new_expected_data = { :site => "#{new_url}" }
      @expected_data << new_expected_data

      @lh.add new_url
      @lh.yml.should eq @expected_data
    end

    it "deletes a url from list/file" do
      @lh.delete('www.google.com')
      @lh.yml.should eq []
    end

    it "edits url from list/file" do
      @lh.edit('www.google.com', 'www.google.co.uk')
      data = [{ :site => 'www.google.co.uk' }]
      @lh.yml.should eq data
    end
  end
end

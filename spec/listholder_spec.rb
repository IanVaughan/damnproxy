require 'listholder'
require 'fakefs/safe'

describe ListHolder do
  before(:each) do
    FakeFS.activate!
    #@lh = ListHolder.new(File.open('config.yml'))
    @lh = ListHolder.new('config.yml')
  end

  context "with no data file" do
    it "saves a new url to list" do
      site = 'www.bar.com'
      expected_data = [{ :site => "#{site}" }]
      @lh.add site
      @lh.yml.should eq expected_data
    end

    it "saves data to file" do
      new_url = 'www.foo.com'
      expected_data = [{ :site => "#{new_url}" }]
      @lh.add(new_url)
      saved_yaml = YAML.load_file('config.yml')
      saved_yaml.should eq expected_data
    end

    after(:each) do
      @lh.clear
      FakeFS.deactivate!
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
      @lh.clear
      FakeFS.deactivate!
    end

    it "loads url from file" do
      @lh.yml.should eq @expected_data
    end

    it "clears urls from list" do
      @lh.clear
      @lh.yml.should eq []
    end

    it "saves a new url to list and file" do
      new_url = 'www.foo.com'
      @expected_data << { :site => "#{new_url}" }

      @lh.add new_url
      @lh.yml.should eq @expected_data
    end

    it "deletes a url from list/file" do
      @lh.delete('www.google.com')
      @lh.yml.should eq []
    end

    it "adds and deletes a url from list/file" do
      new_url = 'www.foo.com'
      expected_data = [{ :site => "#{new_url}" }]
      @lh.add new_url
      @lh.delete('www.google.com')
      @lh.yml.should eq expected_data
    end

    it "edits url from list/file" do
      @lh.edit('www.google.com', 'www.google.co.uk')
      data = [{ :site => 'www.google.co.uk' }]
      @lh.yml.should eq data
    end

    it "allows or does not allow duplicates?" do
      @lh.add('www.google.com')
      @lh.yml.should eq @expected_data << { :site => 'www.google.com' }
    end

  end

  context "using iterators and other cool shit" do
    before(:each) do
      FakeFS.activate!
      @lh = ListHolder.new('config.yml')
    end

    it "adds many urls" do
      url1 = { :site => 'www.google.co.uk' }
      url2 = { :site => 'www.coo.co.uk' }
      @lh.add url1[:site], url2[:site]
      @lh.yml.should eq [url1, url2]
    end

    it "adds a list of urls" do
      pending
      url1 = { :site => 'www.google.co.uk' }
      url2 = { :site => 'www.coo.co.uk' }
      @lh.add [url1[:site], url2[:site]]
      @lh.yml.should eq [url1, url2]
    end

    it "adds a list of urls via a block" do
      pending
      url1 = { :site => 'www.bar' }
      #@lh.add do { | site | url }
      @lh.yml.should eq [url1, url1]
    end

    it "yields each url in a list of urls" do
      @lh.add 'www.google.co.uk', 'www.foo.co.uk'
      #@lh.each_url.should
    end

    after(:each) do
      @lh.clear
      FakeFS.deactivate!
    end

  end

end

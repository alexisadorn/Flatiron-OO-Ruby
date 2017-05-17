require 'bundler'

describe "Bundler" do
  before :all do
    @bundle_output = ""
    Bundler.with_clean_env do
      @bundle_output = `bundle`
    end
  end

  describe "Gemfile" do
    before :all do
      @gemfile_text = File.read('Gemfile')
    end

    it "has correct syntax" do
      expect(@bundle_output).not_to include("There was an error parsing")
    end

    # http://bundler.io/v1.3/gemfile.html
    it "should specify rubygems as a source using the SSL protocol on the first line" do
      expect(@gemfile_text =~ /source .https:\/\/rubygems.org./).not_to eq(nil)
    end

    # http://bundler.io/v1.3/gemfile.html
    it "should list the hashie gem without specifying a version" do
      expect(@gemfile_text =~ /gem .hashie.\r\n?|\n|$/).not_to eq(nil)
    end

    # http://bundler.io/v1.3/gemfile.html
    it "should list the sinatra gem with the specific version 1.4.4" do
      expect(@gemfile_text =~ /gem .sinatra., .v?1\.4\.4./).not_to eq(nil)
    end

    # http://robots.thoughtbot.com/post/2508037841/rubys-pessimistic-operator
    it "should list the octokit gem specifying version 2.0 with a twiddle-wakka" do
      expect(@gemfile_text =~ /gem .octokit.*.~>.?2\.0./).not_to eq(nil)
    end

    # http://bundler.io/git.html
    it "should list the awesome_print gem specifying a remote git repository (use github)" do
      expect(@gemfile_text =~ /gem .awesome_print.,.*git.*/).not_to eq(nil)
    end

    describe "groups" do
      after :each do
        system("rm .bundle/config")
      end

      # http://bundler.io/v1.3/groups.html
      it "should contain the pry gem in the development group using a hash argument to the gem method" do
        expect(@gemfile_text =~ /gem .pry.,.*group.*development'?/).not_to eq(nil)
        expect(@bundle_output =~ /pry/).not_to eq(nil)

        bundle_output_without_development = ""
        Bundler.with_clean_env do
          bundle_output_without_development = `bundle --without development`
        end
        expect(bundle_output_without_development =~ /pry/).to eq(nil)
      end

      # http://bundler.io/v1.3/groups.html
      it "should contain the rspec gem in the test group using block syntax" do
        expect(@gemfile_text =~ /group .*test.* do/).not_to eq(nil)
        expect(@bundle_output =~ /rspec/).not_to eq(nil)

        bundle_output_without_test = ""
        Bundler.with_clean_env do
          bundle_output_without_test = `bundle --without test`
        end
        expect(bundle_output_without_test =~ /rspec/).to eq(nil)
      end
    end
  end

  # This may exist from having run bundle install in other tests
  describe "bundle install" do
    describe "Gemfile.lock" do
      it "should exist after running `bundle install`" do
        expect(File.exists?('Gemfile.lock')).to eq(true)
      end
    end
  end

  describe "integration" do
    before :each do
      @environment_text = File.read('config/environment.rb')
    end

    # http://bundler.io/
    it "should require bundler/setup in the environment" do
      expect(@environment_text =~ /require .bundler\/setup./).not_to eq(nil)
    end

    # http://bundler.io/v1.3/groups.html
    it "should require the default and development groups in the environment" do
      expect(@environment_text =~ /Bundler\.require\(:default, :development\)/).not_to eq(nil)
    end

    it "should make the bundler gems available in bin/run.rb" do
      expect { require_relative "../bin/run.rb" }.not_to raise_error
    end
  end
end

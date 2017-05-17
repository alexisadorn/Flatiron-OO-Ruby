describe "#create_project_hash" do

  it "can be called on with no errors" do
    expect {create_project_hash}.to_not raise_error
  end

  it "returns a hash" do
    expect(create_project_hash.class).to eq(Hash)
  end

  it "includes at least five projects" do
    expect(create_project_hash.length).to be >= 5
  end

  it "project titles point to a hash of info" do
    create_project_hash.each do |project_title, info_hash|
      expect(info_hash.class).to eq(Hash)
    end
  end

  it "each project has an image link hosted on AmazonAWS" do
    create_project_hash.each do |project_title, info_hash|
      regex = /https:\/\/s3.amazonaws.com\//
      expect(regex.match(info_hash[:image_link])).to_not be_nil 
    end
  end

  it "each project has a description which is a string" do
    create_project_hash.each do |project_title, info_hash|
      expect(info_hash[:description].class).to eq(String) 
    end
  end

  it "each project has a location which is a string" do
    create_project_hash.each do |project_title, info_hash|
      expect(info_hash[:location].class).to eq(String) 
    end
  end

  it "each project has percentage funded listed which is an integer" do
    create_project_hash.each do |project_title, info_hash|
      expect(info_hash[:percent_funded].class).to eq(Fixnum) 
    end
  end

end
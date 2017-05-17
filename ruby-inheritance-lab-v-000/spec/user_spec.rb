require "spec_helper"

describe "User" do 
  let!(:user) { User.new }
  it "has a first name" do 
    user.first_name = "Tracy"
    expect(user.first_name).to eq("Tracy")
  end

  it "has a last name" do 
    user.last_name = "Morgan"
    expect(user.last_name).to eq("Morgan")
  end
end
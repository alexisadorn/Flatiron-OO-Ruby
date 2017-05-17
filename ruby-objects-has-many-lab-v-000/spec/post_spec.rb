require "spec_helper"

describe "Post" do 

  let!(:post){Post.new("My Blog Post!")}
  describe "#new" do 
    it "is initialized with an argument of a title" do 
      expect{Post.new("Hello World")}.to_not raise_error
    end
  end

  describe "#title" do 
    it "has a title" do
      expect(post.title).to eq("My Blog Post!")
    end
  end

  describe "#author" do
    it "belongs to an author" do 
      sophie = Author.new("Sophie")
      post.author = sophie
      expect(post.author).to eq(sophie)
    end 
  end

  describe "#author_name" do
    it "knows the name of its author" do 
      sophie = Author.new("Sophie")
      post.author = sophie
      expect(post.author_name).to eq("Sophie")
    end 

    it "returns nil if the post does not have an author" do 
      expect(post.author_name).to eq nil
    end
  end
end

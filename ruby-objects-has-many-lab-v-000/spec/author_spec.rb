require "spec_helper"
require 'pry'

describe "Author" do

  let!(:betty) { Author.new("Betty") } 

    describe "#new" do 
      it "is initialized with a name" do 
        expect{Author.new("Betty")}.to_not raise_error
      end

      it "is initialized with an empty collection of posts" do 
        expect(betty.instance_variable_get(:@posts)).to match([])
      end
    end

    describe "#name" do
      it "has an attr_accessor for name" do 
        expect(betty.name).to eq("Betty")
    end

    describe "#posts" do 
      it "has many posts" do
        expect(betty.posts).to be_a(Array)
      end
    end

    describe "#add_post" do 
      it "takes in an argument of a post and adds that post to the author's collection and tells the post that it belongs to that author" do 
        hello_world = Post.new("Hello World")
        betty.add_post(hello_world)
        expect(betty.posts).to include(hello_world)
        expect(hello_world.author).to eq(betty)
      end
    end

    describe "#add_post_by_title" do 
      it "takes in an argument of a post title, creates a new post with it and associates the post and author" do 
        betty.add_post_by_title("My Great Blog Post")
        # binding.pry
        expect(betty.posts.last.title).to eq("My Great Blog Post")
        expect(betty.posts.last.author).to eq(betty)
      end
    end

    describe ".post_count" do 
      it "is a class method that returns the total number of posts associated to all existing authors" do 
        # binding.pry
        expect(Author.post_count).to eq(2)
      end

      it "uses the class variable, @@post_count" do 
        expect(Author.class_variable_get(:@@post_count)).to be_a(Integer)
      end
    end
  end
end
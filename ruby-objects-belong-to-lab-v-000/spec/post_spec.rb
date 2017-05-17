require "spec_helper"

describe "Post" do
  let!(:post) { Post.new } 
  it "has a title" do
    post.title = "Hello World" 
    expect(post.title).to eq("Hello World")
  end

  it "belongs to an author" do 
    author = Author.new
    post.author = author
    expect(post.author).to eq(author)
  end

  it "knows the name of the author it belongs to" do 
    author = Author.new
    author.name = "Uncle Bob"
    post.author = author
    expect(post.author.name).to eq("Uncle Bob")
  end
end
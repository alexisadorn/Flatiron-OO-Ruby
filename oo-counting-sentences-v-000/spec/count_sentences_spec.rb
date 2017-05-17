describe String do
  describe "#sentence?" do 
    it "returns true if the string that you are calling this method on ends in a period." do 
      expect("Hi, my name is Sophie.".sentence?).to eq(true)
    end

    it "returns false if the string that you are calling this method on does NOT end in a period." do 
      expect("Hi, my name is Sophie".sentence?).to eq(false)
    end

  end

  describe "#question?" do 
    it "returns true if the string that you are calling this method on ends in a question mark." do 
      expect("What's your name?".question?).to eq(true)
    end

    it "returns false if the string that you are calling this method on does NOT end in question mark." do 
      expect("Happy Halloween!".question?).to eq(false)
    end

  end

  describe "#exclamation?" do 
    it "returns true if the string that you are calling this method on ends in an exclamation mark" do 
      expect("Hi, my name is Sophie!".exclamation?).to eq(true)
    end

    it "returns false if the string that you are calling this method on does NOT end in a exclamation mark." do 
      expect("Hi, my name is Sophie".exclamation?).to eq(false)
    end

  end

  describe "#count_sentences" do

    it  "returns the number of sentences in a string" do
      expect("one. two. three?".count_sentences).to eq(3)
    end

    it "returns zero if there are no sentences in a string" do
      expect("".count_sentences).to eq(0)
    end

    it "returns the number of sentences in a complex string" do
      complex_string = "This, well, is a sentence. This is too!! And so is this, I think? Woo..."
      expect(complex_string.count_sentences).to eq(4)
    end
  end


end

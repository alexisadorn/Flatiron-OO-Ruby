require "spec_helper"

describe "ChattyStudent" do 
  
  let!(:chatty_student) { ChattyStudent.new }
  
  describe "#hello" do
    it "returns a greeting phrase plus a long chatty phrase" do  
      expect{chatty_student.hello}.to output("Hey there! I'm so excited to learn stuff.\nHow are you doing today? I'm okay, but I'm kind of tired. Did you watch The Walking Dead last night? You didn't?! Oh man, it was so crazy! What, you don't want any spoilers? Okay well let me just tell you who died...\n").to_stdout
    end
  end

  describe "#raise_hand" do 
    it "returns the phrase 'Pick me!' ten times." do 
      expect{chatty_student.raise_hand}.to output("Pick me!\nPick me!\nPick me!\nPick me!\nPick me!\nPick me!\nPick me!\nPick me!\nPick me!\nPick me!\n").to_stdout
    end
  end
end
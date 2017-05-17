describe "EmailParser" do
  describe '#parse' do
    it "parses CSV emails" do
      expect(EmailParser.new("avi@test.com, arel@test.com").parse).to eq(["avi@test.com", "arel@test.com"])
    end

    it "parses space delimited emails" do
      expect(EmailParser.new("avi@test.com arel@test.com").parse).to eq(["avi@test.com", "arel@test.com"])
    end

    it "parses both CSV and space delimited emails" do
      emails = "avi@test.com, arel@test.com test@avi.com, test@arel.com"
      expect(EmailParser.new(emails).parse).to eq(["avi@test.com", "arel@test.com","test@avi.com", "test@arel.com"]) 
    end

    it 'parses and removes duplicate emails' do
      expect(EmailParser.new("avi@test.com, avi@test.com").parse).to eq(["avi@test.com"])
    end
  end
end

require "spec_helper"

describe "Scraper" do

  let!(:student_index_array) {[{:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"./fixtures/student-site/students/joe-burgess.html"},
                               {:name=>"Mathieu Balez", :location=>"New York, NY", :profile_url=>"./fixtures/student-site/students/mathieu-balez.html"},
                               {:name=>"Diane Vu", :location=>"New York, NY", :profile_url=>"./fixtures/student-site/students/diane-vu.html"}]}

  let!(:student_joe_hash) {{:twitter=>"https://twitter.com/jmburges",
                            :linkedin=>"https://www.linkedin.com/in/jmburges",
                            :github=>"https://github.com/jmburges",
                            :blog=>"http://joemburgess.com/",
                            :profile_quote=>"\"Reduce to a previously solved problem\"",
                            :bio=>
  "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School."}}

  let!(:student_david_hash) {{:linkedin=>"https://www.linkedin.com/in/david-kim-38221690",
 :github=>"https://github.com/davdkm",
 :profile_quote=>
  "\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude",
 :bio=>
  "I'm a southern California native seeking to find work as a full stack web developer. I enjoying tinkering with computers and learning new things!"}}

  describe "#scrape_index_page" do
    it "is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student" do
      index_url = "./fixtures/student-site/index.html"
      scraped_students = Scraper.scrape_index_page(index_url)
      expect(scraped_students).to be_a(Array)
      expect(scraped_students.first).to have_key(:location)
      expect(scraped_students.first).to have_key(:name)
      expect(scraped_students).to include(student_index_array[0], student_index_array[1], student_index_array[2])
    end
  end

  describe "#scrape_profile_page" do
    it "is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student" do
      profile_url = "./fixtures/student-site/students/joe-burgess.html"
      scraped_student = Scraper.scrape_profile_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_joe_hash)
    end

    it "can handle profile pages without all of the social links" do
      profile_url = "./fixtures/student-site/students/david-kim.html"
      scraped_student = Scraper.scrape_profile_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_david_hash)
    end
  end
end

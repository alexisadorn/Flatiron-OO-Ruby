class Person
  attr_accessor :partner, :name

  def initialize(name)
    @name = name
  end

  def get_married(person)
    self.partner = person
    if person.class != Person
      begin
        raise PartnerError
      rescue PartnerError => error
        puts error.message
      end
    else
      person.partner = self
    end
  end

  class PartnerError < StandardError
    #Raise the PartnerError when the argument passed into get_married
    #is not an instance of the Person class
    def message
      "you must give the get_married method an argument of
      an instance of the person class!"
    end
  end

end

beyonce = Person.new("Beyonce")
beyonce.get_married("Jay-Z")
puts beyonce.name

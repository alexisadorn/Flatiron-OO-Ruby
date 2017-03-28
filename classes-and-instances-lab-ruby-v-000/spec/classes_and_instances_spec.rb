require 'spec_helper'

describe 'Dog' do
  it 'is defined within lib/dog.rb' do
    expect(defined?(Dog)).to be_truthy
    expect(Dog).to be_a(Class)
  end

  context 'variables defined in lib/dog.rb' do
    it 'defines a local variable fido as an instance of a Dog' do
      fido = get_variable_from_file("lib/dog.rb", "fido")
      expect(fido).to be_a(Dog)
    end

    it 'defines a local variable snoopy as an instance of a Dog' do
      snoopy = get_variable_from_file("lib/dog.rb", "snoopy")
      expect(snoopy).to be_a(Dog)
    end

    it 'defines a local variable lassie as an instance of a Dog' do
      lassie = get_variable_from_file("lib/dog.rb", "lassie")
      expect(lassie).to be_a(Dog)
    end
  end
end

describe 'Person' do
  it 'is defined within lib/person.rb' do
    expect(defined?(Person)).to be_truthy
    expect(Person).to be_a(Class)
  end

  context 'variables defined in lib/person.rb' do
    it 'defines a local variable adele_goldberg as an instance of a Person' do
      adele_goldberg = get_variable_from_file("lib/person.rb", "adele_goldberg")
      expect(adele_goldberg).to be_a(Person)
    end

    it 'defines a local variable alan_kay as an instance of a Person' do
      alan_kay = get_variable_from_file("lib/person.rb", "alan_kay")
      expect(alan_kay).to be_a(Person)
    end
  end
end

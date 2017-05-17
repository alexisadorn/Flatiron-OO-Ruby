require 'spec_helper'

describe 'Dog' do
  it 'is defined within lib/dog.rb' do
    expect(defined?(Dog)).to be_truthy
    expect(Dog).to be_a(Class)
  end

  describe 'name=' do
    it 'defines an instance variable @this_dogs_name' do
      lassie = Dog.new
      lassie.name = 'Lassie'

      expect(lassie.instance_variable_get("@this_dogs_name")).to eq('Lassie')
    end
  end

  describe 'name' do
    it 'retrieves the value of an instance variable @this_dogs_name' do
      lassie = Dog.new
      lassie.instance_variable_set("@this_dogs_name","Lassie")

      expect(lassie.name).to eq("Lassie")
    end
  end

end

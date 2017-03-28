describe 'Dog' do
  it 'is defined within lib/dog.rb' do
    expect(defined?(Dog)).to be_truthy
    expect(Dog).to be_a(Class)
  end

  describe '#bark' do
    it 'responds to the #bark instance method' do
      fido = Dog.new
      expect(fido).to respond_to(:bark)
    end

    it 'puts "Woof!"' do
      expect($stdout).to receive(:puts).with("Woof!")

      fido = Dog.new
      fido.bark
    end
  end

  describe '#sit' do
    it 'responds to the #sit instance method' do
      fido = Dog.new
      expect(fido).to respond_to(:sit)
    end

    it 'puts "The Dog is sitting"' do
      expect($stdout).to receive(:puts).with("The Dog is sitting")

      fido = Dog.new
      fido.sit
    end
  end
end

describe 'Person' do
  it 'is defined within lib/person.rb' do
    expect(defined?(Person)).to be_truthy
    expect(Person).to be_a(Class)
  end

  describe '#talk' do
    it 'responds to the #talk instance method' do
      ada = Person.new
      expect(ada).to respond_to(:talk)
    end

    it 'puts "Hello World!"' do
      expect($stdout).to receive(:puts).with("Hello World!")

      ada = Person.new
      ada.talk
    end
  end

  describe '#walk' do
    it 'responds to the #walk instance method' do
      ada = Person.new
      expect(ada).to respond_to(:walk)
    end

    it 'puts "The Person is walking"' do
      expect($stdout).to receive(:puts).with("The Person is walking")

      ada = Person.new
      ada.walk
    end
  end
end

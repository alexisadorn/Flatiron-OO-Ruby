describe 'Person' do
  describe '#initialize' do
    it 'sets the name of the person in an instance variable @name' do
      beyonce = Person.new("Beyonce")

      expect(beyonce.instance_variable_get(:@name)).to eq("Beyonce")
    end
  end
end

describe 'Dog' do
  describe '#initialize' do
    it 'sets the name of the dog in an instance variable @name' do
      fido = Dog.new("Fido", "Pug")

      expect(fido.instance_variable_get(:@name)).to eq("Fido")
    end

    it 'sets the breed of the dog in an instance variable @breed' do
      fido = Dog.new("Fido", "Pug")

      expect(fido.instance_variable_get(:@breed)).to eq("Pug")
    end

    it 'defaults the breed argument to "Mutt" in an instance variable @breed' do
      fido = Dog.new("Fido")

      expect(fido.instance_variable_get(:@breed)).to eq("Mutt")
    end
  end
end

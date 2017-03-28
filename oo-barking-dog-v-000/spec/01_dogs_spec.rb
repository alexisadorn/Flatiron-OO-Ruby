describe "Dog" do
  let(:fido) {Dog.new}  # Look up what let does in RSpec
  # https://www.relishapp.com/rspec/rspec-core/v/2-6/docs/helper-methods/let-and-let

  it 'instantiates a new dog' do
    expect(fido).to be_a(Dog)
  end

  it 'has a name' do
    fido.name = "Fido"
    expect(fido.name).to eq("Fido")
  end

   it "is able to bark" do
    # STDOUT is a constant that ruby defines for you
    # that represents 'output' so that you can test
    # against puts and Input/Output (IO) methods
    expect(STDOUT).to receive(:puts).with("woof!")
    fido.bark
  end
end

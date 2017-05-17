describe 'FancyDance::InstanceMethods module' do
  let(:dummy_class) { Class.new { include FancyDance::InstanceMethods }.new }

  it 'has a #twirl method' do
    expect(dummy_class.twirl).to eq("I'm twirling!")
  end

  it 'has a #jump method' do
    expect(dummy_class.jump).to eq("Look how high I'm jumping!")
  end

  it 'has a #pirouette method' do
    expect(dummy_class.pirouette).to eq("I'm doing a pirouette")
  end

  it 'has a #take_a_bow method' do
    expect(dummy_class.take_a_bow).to eq("Thank you, thank you. It was a pleasure to dance for you all.")
  end
end

describe 'FancyDance::ClassMethods module' do 
  let(:dummy_class) {Class.new {extend FancyDance::ClassMethods}}

  it 'has a metadata method' do 
    expect(dummy_class.metadata).to eq("This class produces objects that love to dance.")
  end
end
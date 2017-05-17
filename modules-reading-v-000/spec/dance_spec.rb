describe 'Dance module' do
  let(:dummy_class) { Class.new { include Dance }.new }

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
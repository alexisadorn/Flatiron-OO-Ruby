describe 'Kid' do
  let(:kid) {Kid.new("Pat")}

  it 'includes the Dance module' do
    expect(kid).to have_instance_dance_methods
  end

  it 'has a name' do
    expect(kid.name).to eq('Pat')
  end

  it 'extends the MetaDancing module' do
    expect(Kid).to have_class_dance_methods
  end
end

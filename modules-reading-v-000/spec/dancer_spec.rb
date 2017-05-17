describe 'Dancer' do
  let(:dancer) {Dancer.new('Anna')}

  it 'includes the Dance module' do
    expect(dancer).to have_instance_dance_methods
  end

  it 'has a name' do
    expect(dancer.name).to eq('Anna')
  end

  it 'extends the MetaDancing module' do
    expect(Dancer).to have_class_dance_methods
  end
end

describe 'MetaDancing' do 
  let(:dummy_class) {Class.new {extend MetaDancing}}

  it 'has a metadata method' do 
    expect(dummy_class.metadata).to eq("This class produces objects that love to dance.")
  end
end
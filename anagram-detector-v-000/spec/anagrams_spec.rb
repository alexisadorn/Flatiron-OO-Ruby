describe 'Anagram' do 
  it 'should detect no matches' do
    diaper = Anagram.new('diaper')
    expect(diaper.match(%w(hello world zombies pants dipper))).to eq([])
  end

  it 'should detect a simple anagram' do
    detector = Anagram.new('ba')
    ba = detector.match(['ab', 'abc', 'bac'])
    expect(ba).to eq(['ab'])
  end

  it 'should detect an anagram' do
    detector = Anagram.new('listen')
    listen = detector.match %w(enlists google inlets banana)
    expect(listen).to eq(['inlets'])
  end

  it 'should detect multiple anagrams' do
    detector = Anagram.new('allergy')
    allergy = detector.match %w(gallery ballerina regally clergy largely leading)
    expect(allergy).to eq(['gallery', 'regally', 'largely'])
  end
end

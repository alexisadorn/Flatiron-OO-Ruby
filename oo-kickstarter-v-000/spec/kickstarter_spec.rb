describe 'Backer - ::new' do
  it 'takes a name on initialization' do
    backer = Backer.new("Avi")
    expect(backer.name).to eq("Avi")
  end
end

describe 'Project - ::new' do
  it 'takes a title on initialization' do
    project = Project.new("Project With So Much Amaze")
    expect(project.title).to eq("Project With So Much Amaze")
  end
end

describe 'Backer - #back_project' do
  it 'accepts a Project as an argument and stores it in a backed_projects array' do
    spencer = Backer.new("Spencer")
    magic = Project.new("Magic The Gathering Thing")

    # If we are calling this method in this way, what type of argument is it taking?
    # We are actually passing in a Project object! Cool, huh?
    spencer.back_project(magic)

    expect(spencer.backed_projects).to include(magic)
  end
end

describe 'Project - #add_backer' do
  it 'accepts a Backer as an argument and stores it in a backers array' do
    book = Project.new("Ruby, Ruby, and More Ruby")
    steven = Backer.new("Steven")

    # Same here. We are actually passing around a Backer object. This is pretty
    # simple functionality, but objects can interact with one another in really
    # cool ways.
    book.add_backer(steven)

    expect(book.backers).to include(steven)
  end
end

describe 'Backer - More Advanced #back_project' do
  it 'also adds the backer to the project\'s backers array' do
    logan = Backer.new("Logan")
    hoverboard = Project.new("Awesome Hoverboard")
    logan.back_project(hoverboard)

    # If by this point, the project knows about a new backer, where does that mean
    # some more magic needs to happen? There's really only one place it can happen.
    expect(hoverboard.backers).to include(logan)
  end
end

describe 'Project - More Advanced #add_backer' do
  it 'also adds the project to the backer\'s backed_projects array' do
    ropes = Project.new("All The Ropes")
    arel = Backer.new("Arel")
    ropes.add_backer(arel)

    # Same thing here. There's only one place we can tell arel about his newly
    # backed project. Where does that need to happen?
    expect(arel.backed_projects).to include(ropes)
  end
end
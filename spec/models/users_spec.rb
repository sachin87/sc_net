require 'spec_helper'

describe User do
  before { @user = User.new }
  it { should have_many(:authentications) }
  it { should have_many(:articles) }
  it { should have_many(:entries) }
  it { should have_many(:comments) }
  it { should have_many(:photos) }
  it { should validate_presence_of(:email) }
  it { should_not allow_mass_assignment_of(:admin) }
end
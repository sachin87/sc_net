require 'spec_helper'

describe Page do
  
  before { @page = Page.new }
  it { should validate_presence_of(:title) }

  it "should validate title length" do
    @page.title = "a" * 256
    @page.should be_invalid
    @page.title = "a" * 2
    @page.should be_invalid
  end

  it "should validate body length" do
    @page.body = "a" * 10001
    @page.should be_invalid
    @page.errors[:body].should == ["is too long (maximum is 10000 characters)"]
    @page.body = "a" * 10
    @page.valid?
    @page.errors[:body].should == []
  end

end
require 'rails_helper'

describe Gadget do 
  it "has a valid factory" do
    FactoryGirl.create(:gadget).should be_valid
  end

  it "is valid with a name" do
    FactoryGirl.build(:gadget, :name => "Phone").should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:gadget, :name => nil).should_not be_valid
  end

end
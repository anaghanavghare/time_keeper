require 'spec_helper'

describe User do 
  it "has a valid factory" do
  	u = create(:user).should be_valid
  end
  
  describe "is invalid without" do 
    it "firstname" do
    	build(:user, first_name: nil).should_not be_valid
    end
    it "lastname" do
    	build(:user, last_name: nil).should_not be_valid
    end
    it "email" do
      build(:user, email: nil).should_not be_valid
    end
    it "password" do
      build(:user, password: nil).should_not be_valid
    end
    it "password_confirmation" do
      build(:user, password: "aaa", password_confirmation: nil).should_not be_valid
    end
    it "roles" do
      build(:user, roles: nil).should_not be_valid
    end
  end

  describe "should have" do
    it "same password and password_confirmation" do
      build(:user, password: "aaa", password_confirmation: "acvf").should_not be_valid
    end

    it "same password and password_confirmation" do
      build(:user, password: "aaa", password_confirmation: "aaa").should be_valid
    end
  end

  describe "should have" do
    it "valid email" do
      build(:user, email: 'anagha').should_not be_valid
    end

    it "valid email" do
      build(:user, email: 'anagha@c').should_not be_valid
    end

    it "unique email" do
      u = create(:user)
      build(:user, email: u.email).should_not be_valid
    end
  end

  describe "should" do
    it "have valid role" do 
      build(:user, roles: 'a').should_not be_valid
    end

    it "add role to user" do
      u = build(:user, roles: nil)
      u.add_role('admin')
      u.save.should be_true
    end

    it "update role of user" do
      u = create(:user)
      u.update_role('user')
      u.save.should be_true
    end
  end

  describe "can have" do
    it "projects" do
      u = create(:user)
      u.projects << create(:project)
      u.save.should be_true
    end
  end

end
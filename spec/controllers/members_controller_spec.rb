require 'spec_helper'

describe MembersController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET #index" do
    it "returns all members" do
      create(:user, email:'anaghaw@idyllic-software.com')
      create(:user, email:'damle@widyllic-software.com')
      
      get :index, :format => 'json'
      expect(json)

      body = JSON.parse(response.body)
      emails = body.map { |m| m["email"] }
      expect(emails).to match_array(User.all.map{|u| u.email})
    end
  end
end
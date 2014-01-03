# coding: utf-8
require 'spec_helper'

describe "UserPages" do

  subject {page}



  describe "show page" do

    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.username)}
    it {should have_title(user.username)}
  end


  describe "signup page" do


    before { visit signup_path}
    let(:submit) {"注册"}

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end




  end

end

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

    describe "with empty information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with two password different" do
      before do
        fill_in "Username",         with: "hello"
        fill_in "Email",            with: "test@test.com"
        fill_in "Password",         with: "foobar000"
        fill_in "Password confirmation", with: "foobar111" 
      end
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",         with: "hello"
        fill_in "Email",            with: "test@test.com"
        fill_in "Password",         with: "foobar001"
        fill_in "Password confirmation", with: "foobar001"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end


      describe "after saving the user" do

        before { click_button submit}
        let(:user) {User.find_by(email: 'test@test.com')}

        it {should have_link('退出')}
        it {should have_title(user.username)}
        it {should have_selector('div.alert.alert-success', text: '欢迎你')}

      end
    end
  end

end

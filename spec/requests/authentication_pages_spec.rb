# coding: utf-8
require 'spec_helper'

describe "AuthenticationPages" do
  
  subject {page}

  describe "signin page" do
    before { visit signin_path}

    it {should have_content('登陆')}
    it {should have_title('登陆')}
  end

  describe "signin" do
    before {visit signin_path}

    describe "with invalid information" do

      before { click_button "登陆"}

      it {should have_title('登陆')}
      it {should have_selector('div.alert.alert-error')}

    end

    describe "with valid information" do

      let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in "email", with: user.email.upcase
        fill_in "password", with: user.password
        click_button "登陆"
      end

      it {should have_title(user.name)}
      it {should have_link('资料', href: user_path(user))}
      it {should have_link('退出', href: signout_path)}
      it {should_not have_link('登陆', href: signin_path)}

    end



  end

end

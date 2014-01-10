# coding: utf-8
require 'spec_helper'

describe "UserPages" do

  subject {page}

  #用户的展示页面
  describe "show page" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.username)}
    it {should have_title(user.username)}
  end

  #注册页面
  describe "signup page" do
    before { visit signup_path}
    let(:submit) {"注册"}

    #表单为空
    describe "with empty information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    #两次密码不一致
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

    #填写了合法的信息
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


      #注册成功后
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

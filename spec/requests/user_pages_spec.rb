require 'spec_helper'

describe "UserPages" do

  subject {page}

  describe "signup page" do


    before { visit signup_path}

    it {should have_content('用户注册')}
    it {should have_title('注册')}
  end

  describe "show page" do

    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.username)}
    it {should have_title(user.username)}
  end

end

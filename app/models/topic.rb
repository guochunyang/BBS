class Topic < ActiveRecord::Base
  validates :title, :presence => true, :length => {:maximum => 25}
  validates :body, :presence => true
end

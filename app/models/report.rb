class Report < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :comments
  attr_accessible :description, :title, :type, :client_id, :user_id

  scope :publik, where(:public => true)
  
  paginates_per 25
  
  default_scope order('created_at desc')
  
  accepts_nested_attributes_for :client
  make_voteable
end

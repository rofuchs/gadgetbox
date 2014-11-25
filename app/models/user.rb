class User < ActiveRecord::Base
  has_many :gadgets
  validates :name, presence: true
end

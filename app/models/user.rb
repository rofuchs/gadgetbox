class User < ActiveRecord::Base
  has_many :gadgets
end

class Image < ActiveRecord::Base
  belongs_to :gadget
  validates :gadget, :presence => true
end

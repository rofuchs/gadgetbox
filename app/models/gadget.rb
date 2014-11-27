class Gadget < ActiveRecord::Base
  belongs_to :user
  has_many :images
  validates :name, :presence => true
  accepts_nested_attributes_for :images, allow_destroy: true
end

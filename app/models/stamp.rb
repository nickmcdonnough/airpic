class Stamp < ActiveRecord::Base
  validates :quantity, numericality: true
  validates :date, numericality: true
  belongs_to :user
end
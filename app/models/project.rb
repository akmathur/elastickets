class Project < ActiveRecord::Base
  has_many :tickets, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end

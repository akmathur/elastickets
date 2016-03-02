class Ticket < ActiveRecord::Base
  belongs_to :project

  validates :title, presence: true
  validates :description, presence: true

  # Extensions
  serialize :extended_attrs, Hash
  validates_with ExtensionValidator
  include ExtensionUtilities
end

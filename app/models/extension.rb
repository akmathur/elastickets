class Extension < ActiveRecord::Base
  ATTR_TYPES = ['text_field', 'select', 'multiselect', 'check_boxes', 'radio_buttons', 'text_area']

  validates :target_model, presence: true,
                           inclusion: { in: Proc.new { Extension.models_list } }
  validates_inclusion_of :default, in: Proc.new { |e| e.values.split(', ') }, if: Proc.new { |e| e.values.present? && e.values.size > 0 }, allow_blank: true
  validates :position, numericality: true
  validates :label, presence: true
  validates :attr_name, presence: true
  validates :attr_type, presence: true, inclusion: ATTR_TYPES

  def values=(str)
    write_attribute(:values, str.split(',').map(&:strip).reject(&:blank?).join(', '))
  end

  def parameterized_label
    self.label.parameterize.underscore
  end

  def self.models_list
    Rails.application.eager_load! if Rails.env.development?
    ActiveRecord::Base.descendants.map(&:to_s) - ["ActiveRecord::SchemaMigration", "Extension"]
  end

  def self.permitted_params(target_model)
    Extension.where(target_model: target_model).map { |extension|
      ['multiselect', 'check_boxes'].include?(extension.attr_type) ? {extension.attr_name => []} : extension.attr_name
    }
  end
end

class ExtensionValidator < ActiveModel::Validator
  def validate(record)
    Extension.where(target_model: record.class.to_s).order("position").each do |extension|
      if extension.is_required? && record.extended_attrs[extension.attr_name].blank?
        record.errors.add(extension.parameterized_label.to_sym, " can't be blank")
      end
    end
  end
end

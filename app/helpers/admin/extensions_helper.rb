module Admin::ExtensionsHelper
  def extended_field_tag(form, extension)
    field_name = "#{form.object.class.to_s.underscore}[extended_attrs][#{extension.attr_name}]"
    field_value = form.object.send(extension.attr_name)
    case extension.attr_type
    when 'text_field'
      text_field_tag(field_name, field_value)
    when 'select'
      select_tag(field_name, options_for_select(extension.values.split(', '), field_value))
    when 'multiselect'
      select_tag("#{field_name}[]", options_for_select(extension.values.split(', '), field_value), multiple: true)
    when 'check_boxes'
      extension.values.split(', ').map { |value| check_box_tag("#{field_name}[]", value, field_value.try(:include?, value)) + " #{value}"}.join(' ').html_safe
    when 'radio_buttons'
      extension.values.split(', ').map { |value| radio_button_tag(field_name, value, value == field_value) + " #{value}" }.join(' ').html_safe
    when 'text_area'
      text_area_tag field_name, field_value
    end
  end
end

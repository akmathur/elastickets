module ExtensionUtilities
  def method_missing(method, *args, &block)
    operation, attr_name = if method.to_s.match(/=$/)
                             [:write, method.to_s.sub(/=$/, '')]
                           else
                             [:read, method.to_s]
                           end
    extension = Extension.where(target_model: self.class.to_s, attr_name: attr_name)

    if extension.present?
      if operation == :read
        extended_attrs[attr_name].presence || extension.first.default
      else
        extended_attrs[attr_name] = args.first
      end
    else
      super
    end
  end
end

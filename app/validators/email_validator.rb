class EmailValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[-a-z0-9_+\.]+@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
      object.errors.add(attribute, (options[:message] || I18n.t('custom_validator_messages.email')))
    end
  end
end
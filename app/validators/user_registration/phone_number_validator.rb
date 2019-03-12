class UserRegistration::PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    unless phone_number_valid?(record.user['sms_number'])
      record.errors.add(:base, I18n.t(:valid_phone_number_required))
    end
  end

  private

  def phone_number_valid?(phone_number)
    # gratitude for this answer: https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number
    phone_number =~ /^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$/
  end
end
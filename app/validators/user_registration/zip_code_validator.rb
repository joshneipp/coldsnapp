class UserRegistration::ZipCodeValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, I18n.t(:valid_zip_code_required)) unless zip_code_length_five?(record.user[:settings][:zip_code])
  end

  private

  def zip_code_length_five?(zip_code)
    zip_code.length == 5 && zip_code.to_i.to_s.length == 5
  end
end
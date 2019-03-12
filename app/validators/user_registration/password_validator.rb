class UserRegistration::PasswordValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, 'Password is required') unless record.user.key?('password') && record.user['password'].present?
  end
end
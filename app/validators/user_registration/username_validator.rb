class UserRegistration::UsernameValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, 'Username is required') unless record.user.key?('username') && record.user['username'].present?
  end
end
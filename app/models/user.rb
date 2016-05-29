class User < ActiveRecord::Base
  validates :mobile_number, uniqueness: true

  acts_as_authentic do |c|
    c.validate_email_field = false
    c. validate_login_field = false
  end

  def generate_verification_code
    self.verification_code = rand(0000...9999).to_s.rjust(4, '0')
    self.is_verified = false
    save
  end

  def send_verification_code
    puts self.verification_code
  end

  def verify(entered_verification_code)
    update(is_verified: true) if self.verification_code == entered_verification_code
    self.is_verified
  end

  def verify(entered_verification_code)
    update(is_verified: true) if self.verification_code == entered_verification_code
    self.is_verified
  end
end

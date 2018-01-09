class PaymentRequest < ApplicationRecord

  after_validation :generate_token

  private

  def generate_token
    begin
      self.token = random_token = "lpt_#{SecureRandom.hex(12)}"
    end while self.class.exists?(token: token)
  end
end

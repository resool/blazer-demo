class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def deactivate!
    self.deactivated_at = Time.now
    set_random_email
    save!
  end

  private

  def set_random_email
    loop do
      self.email = Faker::Internet.safe_email
      return unless User.exists?(email: self.email)
    end
  end
end

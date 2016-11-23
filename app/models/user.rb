class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable, :omniauthable

  has_many :identities, dependent: :destroy
end

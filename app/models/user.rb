class User < ApplicationRecord
  include TokenAuthenticatable

  validates_presence_of :email, :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end

class User < ActiveRecord::Base

  has_and_belongs_to_many :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :inviting

  def password_required?
    false if inviting
  end

end

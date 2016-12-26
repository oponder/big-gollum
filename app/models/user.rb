class User < ActiveRecord::Base

  has_and_belongs_to_many :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  easy_roles :roles_mask, method: :bitmask

  ROLES_MASK = %w[create_wiki delete_wiki edit_wiki]
end

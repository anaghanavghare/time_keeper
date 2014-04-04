require 'rubygems'
require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include RoleModel

  roles_attribute :roles_mask

  roles :admin, :user

  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles,:first_name, :last_name

  has_many :projects, dependent: :destroy

  def add_role(user_role)
    return self if user_role.blank?
    _role = user_role.to_s.downcase.to_sym
    self.roles << _role  unless self.has_role?(_role)
    self
  end

  def add_role!(user_role)
    add_role(user_role).save
  end

  def update_role(user_role)
    return self if user_role.blank?
    _role = user_role.to_s.downcase.to_sym
    self.roles = _role  #unless self.has_role?(_role)
    self
  end
end

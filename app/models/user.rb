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

  validates_presence_of :roles, :first_name, :last_name

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

  def as_json
    response_hash = {
      :first_name => self.first_name,
      :last_name => self.last_name,
      :id => self.id,
      :roles => self.roles.first,
      :email => self.email
    }
    response_hash
  end
end

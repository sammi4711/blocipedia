class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  before_save { self.role ||= :standard_member }

  enum role: [:standard_member, :premium_member, :admin]

end
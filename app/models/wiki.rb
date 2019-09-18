class Wiki < ApplicationRecord
  belongs_to :user

  after_initialize :init
  def init
    self.private = false if (self.has_attribute? :private) && self.private.nil?
  end

  #default_scope { order('rank DESC') }

  has_many :collaborators
  has_many :users, through: :collaborators 
  has_many :users, through: :collaborators, dependent: :destroy 

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true  
  #validates :user, presence: true 

  def set_default_privacy
    self.private ||= false
  end

end

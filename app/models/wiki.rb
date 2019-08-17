class Wiki < ApplicationRecord
  belongs_to :user

  after_initialize :init
  def init
    self.private = false if (self.has_attribute? :private) && self.private.nil?
  end

  #default_scope { order('rank DESC') }

  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true  
  #validates :user, presence: true 

end

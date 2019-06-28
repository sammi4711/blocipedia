class Wiki < ApplicationRecord
  belongs_to :user

  #default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true  
  #validates :user, presence: true 

end

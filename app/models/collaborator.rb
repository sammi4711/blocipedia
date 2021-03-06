class Collaborator < ActiveRecord::Base
#class Collaborator < ApplicationRecord
  belongs_to :wiki
  belongs_to :user

  validates :user_id, uniqueness: { scope: :wiki_id }
end
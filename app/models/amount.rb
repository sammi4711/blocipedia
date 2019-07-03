class Amount < ApplicationRecord
  belongs_to :charges 

  def default
    15_00
  end

end
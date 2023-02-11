class Question < ApplicationRecord
  def hide
    update(hidden: true)
  end

end

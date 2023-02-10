class Question < ApplicationRecord
  def hide
    update(hidden: true)
  end

  def hidden?
    self.hidden
  end

  def shown?
    !self.hidden
  end
end

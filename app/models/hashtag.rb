class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]]+(?:-[[:word:]]+)*/.freeze

  scope :with_questions, -> { where.associated(:question_tags) }

  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags
end

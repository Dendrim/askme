class Question < ApplicationRecord
  after_save_commit :save_hashtags

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :destroy
  has_many :hashtags, through: :question_tags

  validates :body, presence: true, length: { maximum: 280 }

  private

  def save_hashtags
    hashtags_to_add = ("#{body} #{answer}").scan(Hashtag::REGEX).map(&:downcase)

    self.hashtags = hashtags_to_add.uniq.map do |hashtag|
      Hashtag.create_or_find_by(body: hashtag.delete('#'))
    end
  end
end

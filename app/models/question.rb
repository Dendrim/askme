class Question < ApplicationRecord
  before_commit :find_hashtags

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :body, presence: true, length: { maximum: 280 }

  private

  def find_hashtags
    hashtags.delete_all

    hashtags_to_add = body.scan(/#\w+/).map(&:downcase) +
                      answer.scan(/#\w+/).map(&:downcase)

    hashtags_to_add.uniq.each do |hashtag|
      hashtags << Hashtag.where(body: hashtag).first_or_create
    end
  end
end

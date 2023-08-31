class Hashtag < ApplicationRecord
  REGEX = /#[\wа-яА-Я]+/

  has_and_belongs_to_many :questions
end

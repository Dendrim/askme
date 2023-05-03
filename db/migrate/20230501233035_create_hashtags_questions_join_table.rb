class CreateHashtagsQuestionsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :questions, :hashtags
  end
end

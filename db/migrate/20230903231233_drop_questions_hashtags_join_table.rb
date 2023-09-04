class DropQuestionsHashtagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :questions, :hashtags
  end
end

class MakeNicknameUnique < ActiveRecord::Migration[7.0]
  def up
    add_index :users, :nickname, unique: true
  end
end

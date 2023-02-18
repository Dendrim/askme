class MakeNicknameUnique < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :nickname, :string, index: { unique: true }
  end
end

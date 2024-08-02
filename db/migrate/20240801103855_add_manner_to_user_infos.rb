class AddMannerToUserInfos < ActiveRecord::Migration[7.0]
  def change
    add_column :user_infos, :manner_categories, :string, array: true, default: []
  end
end

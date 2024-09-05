class RemoveNotifyFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :notify_when_added_to_room, :boolean
  end
end

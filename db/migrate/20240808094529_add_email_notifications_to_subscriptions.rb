class AddEmailNotificationsToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :notify_when_added_to_room, :boolean, default: true
  end
end

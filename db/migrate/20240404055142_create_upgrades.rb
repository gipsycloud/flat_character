class CreateUpgrades < ActiveRecord::Migration[7.0]
  def change
    create_table :upgrades do |t|
      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true
      t.datetime   :startDate
      t.datetime   :endDate
      t.integer    :duration
      t.string     :status

      t.timestamps
    end
  end
end

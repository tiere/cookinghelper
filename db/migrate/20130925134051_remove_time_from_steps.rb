class RemoveTimeFromSteps < ActiveRecord::Migration
  change_table :steps do |t|
    t.remove :time
    t.integer :duration
  end
end

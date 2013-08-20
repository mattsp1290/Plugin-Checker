class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|

      t.timestamps
    end
  end
end

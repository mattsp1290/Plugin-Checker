class AddColumnsToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :os, :string
    add_column :checks, :browser, :string
    add_column :checks, :uas, :string
    add_column :checks, :resolution, :string
    add_column :checks, :cookies, :string
    add_column :checks, :popups, :string
    add_column :checks, :flash, :string
    add_column :checks, :java, :string
    add_column :checks, :reader, :string
    add_column :checks, :zoom, :string
    add_column :checks, :comp, :string

  end
end

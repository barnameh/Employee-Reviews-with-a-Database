require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection ( {
  adapter: 'sqlite3',
  database: 'dev.sqlite3'
  })


  class InitialMigration < ActiveRecord::Migration[5.0]

    def change
      create_table :employees do |t|
        t.string :name
        t.string :email
        t.string :phone
        t.float  :salary
        t.integer :department_id
        t.text   :review
        t.boolean :satisfactory
      end

      create_table :departments do |t|
        t.string :name
      end
    end

  end

  begin
    InitialMigration.migrate(:down)
  rescue
  end

  begin
    InitialMigration.migrate(:up)
  rescue
  end

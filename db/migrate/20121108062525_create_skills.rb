class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.timestamps
    end
    create_table :skills_users do |t|
      t.references :user
      t.references :skill
    end
  end
end

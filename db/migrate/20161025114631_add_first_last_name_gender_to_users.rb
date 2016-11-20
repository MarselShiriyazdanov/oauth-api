class AddFirstLastNameGenderToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender, default: ""
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :passord
      t.string :email
      t.string :birthday
      t.string :gender
      t.string :status

      # t.string :password_hash
      # t.string :password_salt

      t.timestamps null: false
    end
  end
end

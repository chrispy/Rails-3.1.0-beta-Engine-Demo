class CreateUsers< ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false
      t.string :name
      t.string :email, :null => false

      t.timestamps
    end
    add_index :users, :login
  end


  def self.down
    drop_table :users
  end

end

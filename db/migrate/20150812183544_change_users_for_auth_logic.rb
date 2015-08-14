class ChangeUsersForAuthLogic < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :password_digest
      t.remove :remember_token
      t.remove :pool_id
      
      # Authlogic::ActsAsAuthentic::Password
      t.string :crypted_password
      t.string :password_salt
      
      # Authlogic::ActsAsAuthentic::PersistenceToken
      t.string :persistence_token

      # Authlogic::ActsAsAuthentic::PerishableToken
      t.string    :perishable_token

      # Authlogic::Session::MagicColumns
      t.integer :login_count, default: 0, null: false
      t.integer :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      # Authlogic::Session::MagicStates
      t.boolean   :active, default: false

      # Email Validation
      t.boolean :verified, default: false
    end
  end
  def self.down
    change_table :users do |t|
      
      t.string :password_digest
      t.string :remember_token
      t.integer :pool_id

      t.remove :crypted_password
      t.remove :password_salt
      t.remove :persistence_token
      t.remove :perishable_token
      t.remove :login_count
      t.remove :failed_login_count
      t.remove :last_request_at
      t.remove :current_login_at
      t.remove :last_login_at
      t.remove :current_login_ip
      t.remove :last_login_ip
      t.remove :active
      t.remove :verified

    end
  end
end

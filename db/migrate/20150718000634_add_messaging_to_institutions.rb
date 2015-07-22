class AddMessagingToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :defaultMessageNumber, :integer
  end
end

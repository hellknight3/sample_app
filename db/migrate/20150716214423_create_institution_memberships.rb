class CreateInstitutionMemberships < ActiveRecord::Migration
  def change
    create_table :institution_memberships do |t|
      t.timestamps
    end
      add_reference :institution_memberships, :institution
      add_reference :institution_memberships, :memberable, polymorphic: true
      add_index :institution_memberships, ["memberable_id","memberable_type"], :name => "index_institution_memberable"
        #index_institution_memberships_on_memberable_id_and_memberable_type
  end
end

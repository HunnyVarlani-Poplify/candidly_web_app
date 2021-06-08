class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name 
      t.string :website 
      t.string :contact_no 
      t.string :address
      t.references :tenant, index: true 
      t.timestamps
    end
  end
end

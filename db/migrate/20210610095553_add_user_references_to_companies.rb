class AddUserReferencesToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_reference :companies, :user, null: true, foreign_key: true
  end
end
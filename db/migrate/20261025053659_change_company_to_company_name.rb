class ChangeCompanyToCompanyName < ActiveRecord::Migration[8.0]
  def change
    rename_column :job_listings, :company, :company_name
  end
end

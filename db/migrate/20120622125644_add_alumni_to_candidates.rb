class AddAlumniToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :alumni, :boolean
  end
end

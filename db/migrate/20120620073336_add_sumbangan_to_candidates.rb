class AddSumbanganToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :sumbangan, :float
  end
end

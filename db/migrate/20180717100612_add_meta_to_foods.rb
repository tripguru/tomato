class AddMetaToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :meta, :json
  end
end

class AddThemeToRepository < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :theme, :string, index: true
  end
end

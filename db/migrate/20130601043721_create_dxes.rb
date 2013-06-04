class CreateDxes < ActiveRecord::Migration
  def change
    add_column :dxes, :name, :string
    add_column :dxes, :definition, :string
    add_column :dxes, :dx_code, :string
    add_column :dxes, :codes, :string
    add_column :dxes, :resource_uri, :string
  end
end

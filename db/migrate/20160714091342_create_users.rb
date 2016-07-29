class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      # 自动创建 created_at 和 updated_at 两个列
      t.timestamps
    end
  end
end

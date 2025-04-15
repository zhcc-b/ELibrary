class AddDeviseFieldsAndRemovePasswordDigest < ActiveRecord::Migration[7.0]
  def change
    # 移除 password_digest 字段
    remove_column :users, :password_digest if column_exists?(:users, :password_digest)

    # 添加 Devise 所需字段
    add_column :users, :encrypted_password, :string, null: false, default: "" unless column_exists?(:users, :encrypted_password)
    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)

    # 添加索引
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end
end

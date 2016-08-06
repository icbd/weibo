class AddRemembermeDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rememberme_digest, :string
  end
end

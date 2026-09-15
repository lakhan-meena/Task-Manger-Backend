class CreateAuthTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :auth_tokens do |t|
      t.string :access_token, null: false
      t.string :refresh_token, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class AddResetPasswordSentAtToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :reset_password_sent_at, :datetime
  end
end

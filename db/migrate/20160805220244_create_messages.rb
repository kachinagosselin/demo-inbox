class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id
      t.integer :recipient_id
      t.string :status
      t.integer :replied_to
      t.string :title
      t.string :message_type
      t.string :sms_id
      t.string :email_id

      t.timestamps null: false
    end
  end
end

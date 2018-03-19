class AddSlackColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slack_team_name, :string
    add_column :users, :slack_channel_name, :string
    add_column :users, :slack_webhook_url, :string
  end
end

class Api::CallController < Api::ApplicationController

  def index
    notifier = Slack::Notifier.new(current_user.slack_webhook_url)
    notifier.ping 'ping'
    render json: { result: true }
  rescue
    render json: { result: false }
  end
end

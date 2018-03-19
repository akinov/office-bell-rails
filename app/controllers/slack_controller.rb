class SlackController < ApplicationController
  before_action :authenticate_user!

  def authorize_callback
    if callback_params.present?
      uri = URI('https://slack.com/api/oauth.access')
      uri.query = URI.encode_www_form({
        client_id: ENV['SLACK_CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET']
      }.merge(callback_params))

      json = Net::HTTP.get(uri)
      response = JSON.parse(json)
      Rails.logger.info response

      if response['ok']
        current_user.update(slack_access_token: response['access_token'])
        return redirect_to dashboard_index_path, notice: 'Slack連携が完了しました'
      end
    end

    # 何かしらのエラー
    redirect_to dashboard_index_path, notice: 'Slack連携に失敗しました'
  end

  private

  def callback_params
    params.permit(:code)
  end
end

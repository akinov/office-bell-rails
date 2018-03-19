class SlackController < ApplicationController
  def authorize_callback
    if callback_params.present?
      uri = URI('https://slack.com/api/oauth.access')
      uri.query = {
        client_id: SLACK_CLIENT_ID,
        client_secret: CLIENT_SECRET
      }.merge(callback_params)
      json = Net::HTTP.get(uri)

      if json['ok']
        current_user.update(slack_access_token: json['access_token'])
        redirect_to dashboard_index_path, notice: 'Slack連携が完了しました'
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

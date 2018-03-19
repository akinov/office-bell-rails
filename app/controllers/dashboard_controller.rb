class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certification_url, if: -> { current_user.slack_access_token.blank? }

  def index
  end

  private

  def set_certification_url
    @certification_url = URI(ENV['SLACK_CERTIFICATION_BAES_URL'])
    @certification_url.query = URI.encode_www_form({
      client_id: ENV['SLACK_CLIENT_ID'],
      scope: 'incoming-webhook',
    })
  end
end

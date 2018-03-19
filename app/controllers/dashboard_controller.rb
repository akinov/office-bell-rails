class DashboardController < ApplicationController
  before_action :set_certification_url if current_user.slack_access_token.blank?

  def index
  end

  private

  def set_certification_url
    @certification_url = URI(SLACK_CERTIFICATION_BAES_URL)
    @certification_url.query = {
      client_id: SLACK_CLIENT_ID,
      scope: 'chat:write:bot'
    }
  end
end

# app/serializers/api/session_serializer.rb
module Api
  class SessionSerializer < ActiveModel::Serializer

    attributes :authentication_token

    def authentication_token
      object.ensure_authentication_token
    end
  end
end
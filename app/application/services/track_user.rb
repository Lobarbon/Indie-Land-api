# frozen_string_literal: true

require 'dry/monads'

module IndieLand
  module Service
    # Track user login number
    # :reek:FeatureEnvy
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:UtilityFunction
    class TrackUser
      include Dry::Monads::Result::Mixin

      def call(input)
        user_mgr = IndieLand::Repository::Users.manager
        user_id = get_valid_user_id(user_mgr, input[:user_id])

        login_number = user_mgr.login_number(user_id)
        user_mgr.increment_login_number(user_id)
        Success(user_id: user_id, login_number: login_number)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('User module is broken')
      end

      private

      def get_valid_user_id(user_mgr, user_id)
        if !user_mgr.user_exist?(user_id)
          user_mgr.create_user
        else
          user_id
        end
      end
    end
  end
end

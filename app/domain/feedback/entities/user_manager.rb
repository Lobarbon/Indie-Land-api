# frozen_string_literal: true

require 'date'
require 'singleton'
require 'securerandom'

module IndieLand
  module Entity
    # This class will mantain an user map
    # TODO: we should delete users to avoid memory leak
    class UserManager
      include Singleton

      attr_reader :user_map

      def initialize
        @user_map = {}
      end

      def create_new_user
        uid = SecureRandom.uuid
        user_map[uid] = DateTime.now

        uid
      end

      def user_exist?(uid)
        user_map.key?(uid)
      end

      def update_user_login_time(uid)
        user_map[uid] = DateTime.now
      end

      def login_time(uid)
        user_map[uid]
      end
    end
  end
end

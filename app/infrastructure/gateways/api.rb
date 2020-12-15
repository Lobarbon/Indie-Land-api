# frozen_string_literal: true

require 'http'
require 'json'

module IndieLand
  module MinistryOfCulture
    # Define bahaviors of all api classes
    class Response < SimpleDelegator
      module Errors
        # Define error
        class NotFound < StandardError; end
      end

      attr_reader :response

      HTTP_ERROR = {
        404 => Errors::NotFound
      }.freeze

      def initialize(response)
        super(response)
        @response = response
        check_error
      end

      def check_error
        raise HTTP_ERROR[@response.code] if HTTP_ERROR.keys.include?(response.code)
      end
    end

    # MusicApi get json
    class MusicApi
      def initialize
        @url = 'https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=5'
      end

      def data
        JSON.parse(Response.new(HTTP.get(@url)).response)
      end
    end
    
    # Ticket get json forom KKTIX
    class TicketApi
      def initialize
        @url = 'https://riversidemusiccafe.kktix.cc/events.json'
      end  

      def data
        JSON.parse(Response.new(HTTP.get(@url)).response)['entry']
      end
    end
  end
end

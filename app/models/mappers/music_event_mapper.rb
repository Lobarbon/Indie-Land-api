# frozen_string_literal: true

module IndieLand
  # Data Mapper
  class MusicEventsMapper
    def initialize(gateway_class = MusicApi)
      @gateway_class = gateway_class
      @gateway = @gateway_class.new
    end

    def find_events
      build_entity
    end

    private

    def build_entity
      @gateway.data.map do |event|
        EventMapper.new(event).build_entity
      end
    end

    # Extracts entity specific elements from data structure
    class EventMapper
      def initialize(event)
        @event = event
      end

      def build_entity
        IndieLand::Entity::Event.new(
          database_id: nil,
          unique_id: unique_id,
          event_name: event_name,
          main_website: main_website,
          ticket_website: ticket_website,
          website_platform: website_platform,
          description: description,
          sessions: sessions
        )
      end

      private

      def unique_id
        @event['UID']
      end

      def event_name
        @event['title']
      end

      def main_website
        @event['sourceWebPromote']
      end

      def ticket_website
        @event['webSales']
      end

      def website_platform
        @event['sourceWebName']
      end

      def description
        @event['descriptionFilterHtml']
      end

      def sessions
        @event['showInfo'].map do |session|
          SessionMapper.new(session).build_entity
        end
      end
    end

    # SessionMapper will map sessions of an event
    class SessionMapper
      def initialize(session)
        @session = session
      end

      def build_entity
        IndieLand::Entity::Session.new(
          session_id: nil,
          event_id: nil,
          start_time: start_time,
          end_time: end_time,
          price: price,
          address: address,
          place: place
        )
      end

      def start_time
        @session['time']
      end

      def end_time
        @session['endTime']
      end

      def price
        @session['price']
      end

      def address
        @session['location']
      end

      def place
        @session['locationName']
      end
    end
  end
end

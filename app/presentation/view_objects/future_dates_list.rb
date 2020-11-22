require_relative 'event'

module Views
    class FutureEvents
        def initialize(events)
            @events = events.map.with_index { |event, i| Event.new(event, i) }
        end
    
        def each
            @events.each do |event|
            yield event
            end
        end
    
        def any?
            @events.any?
        end
    end
end

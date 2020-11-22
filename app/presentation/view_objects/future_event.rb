

module Views
    # View for a single event entity
    class Event
        def initialize(event, index = nil)
            @event = event
            @index = index
        end

        def entity
            @event
        end
    end
end
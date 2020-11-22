# frozen_string_literal: true

module Views
  # View Object Future Dates
  class FutureDates
    def initialize(dates)
      @dates = dates.map { |date| FutureEvent.new(date) }
    end

    def each(&block)
      @dates.each(&block)
    end

    def any?
      @dates.any?
    end
  end
end

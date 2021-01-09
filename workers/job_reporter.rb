# frozen_string_literal: true

require_relative 'progress_publisher'

module IndieLand
  # Reports comment job progress to client
  class JobReporter
    def initialize(queue_msg, api_host)
      @publisher = ProgressPublisher.new(api_host, queue_msg.request_id)
    end

    def report(msg)
      @publisher.publish msg
    end
  end
end

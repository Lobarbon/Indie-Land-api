# frozen_string_literal: true

require_relative '../init'

require 'econfig'
require 'shoryuken'

# Shoryuken worker class to clone repos in parallel
class MsgWorker
  extend Econfig::Shortcut
  Econfig.env = ENV['RACK_ENV'] || 'development'
  Econfig.root = File.expand_path('..', File.dirname(__FILE__))

  Shoryuken.sqs_client = Aws::SQS::Client.new(
    access_key_id: config.AWS_ACCESS_KEY_ID,
    secret_access_key: config.AWS_SECRET_ACCESS_KEY,
    region: config.AWS_REGION
  )

  include Shoryuken::Worker
  shoryuken_options queue: config.MSG_QUEUE_URL, auto_delete: true

  def perform(_sqs_msg, request)
    queue_msg = IndieLand::Representer::QueueMsg.new(OpenStruct.new).from_json(request)

    if queue_msg.comment == ''
      IndieLand::Repository::Events.like_event(queue_msg.event_id)
    else
      IndieLand::Repository::Comments.comment(queue_msg.event_id, queue_msg.comment)
    end
  rescue StandardError => e
    puts e.backtrace.join("\n")
  end
end

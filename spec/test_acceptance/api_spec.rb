# frozen_string_literal: true

require_relative '../helpers/spec_helper'
require_relative '../helpers/vcr_helper'
require_relative '../helpers/database_helper'
require 'rack/test'

def app
  IndieLand::App
end

# rubocop:disable Metrics/BlockLength
describe 'Test API routes' do
  include Rack::Test::Methods

  VcrHelper.setup
  # DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.insert
    # do not wipe the database before we figure out how to disable cache
    # DatabaseHelper.wipe_database

    logger = IndieLand::AppLogger.instance.get
    IndieLand::Service::Tickets.new.call(logger: logger)
    IndieLand::Service::ListEvents.new.call(logger: logger)
  end

  after do
    VcrHelper.eject
  end

  describe 'Root route' do
    it 'should successfully return root information' do
      get '/'
      _(last_response.status).must_equal 200

      body = JSON.parse(last_response.body)
      _(body['status']).must_equal 'ok'
      _(body['message']).must_include 'api/v1'
    end
  end

  describe 'Get all future events' do
    it 'should successfully return events' do
      get '/api/v1/events'
      _(last_response.status).must_equal 200

      response = JSON.parse(last_response.body)
      range_events = response['range_events']
      _(range_events.count).wont_equal 0

      events_on_date = range_events[0]
      _(events_on_date['date']).wont_be_nil
      _(events_on_date['daily_events']).wont_be_nil
      _(events_on_date['daily_events'].count).wont_equal 0

      event = events_on_date['daily_events'][0]
      _(event['event_id']).wont_be_nil
      _(event['event_name']).wont_be_nil
      _(event['session_id']).wont_be_nil
      _(event['links']).wont_be_nil
    end
  end

  describe 'Get events' do
    it 'should successfully return event info' do
      get '/api/v1/events'
      _(last_response.status).must_equal 200

      response = JSON.parse(last_response.body)
      range_events = response['range_events']
      event = range_events[0]['daily_events'][0]
      event_id = event['event_id']

      get "/api/v1/events/#{event_id}"
      _(last_response.status).must_equal 200

      reponse_event = JSON.parse(last_response.body)
      _(reponse_event['event_id']).must_equal event_id
      _(reponse_event['event_name']).must_equal event['event_name']
      _(reponse_event['event_website']).wont_be_nil
      _(reponse_event['sale_website']).wont_be_nil
      _(reponse_event['source']).wont_be_nil
      _(reponse_event['sessions']).wont_be_nil

      reponse_session = reponse_event['sessions'][0]
      _(reponse_session['event_id']).must_equal event_id
      _(reponse_session['session_id']).must_equal event['session_id']
      _(reponse_session['start_time']).wont_be_nil
      _(reponse_session['end_time']).wont_be_nil
      _(reponse_session['address']).wont_be_nil
      _(reponse_session['place']).wont_be_nil
      _(reponse_session['ticket_price']).wont_be_nil

      get '/api/v1/events/search?q=%E4%BD%A0' # %E4%BD%A0 stands for you in Chinese
      _(last_response.status).must_equal 200
    end
  end
end
# rubocop:enable Metrics/BlockLength

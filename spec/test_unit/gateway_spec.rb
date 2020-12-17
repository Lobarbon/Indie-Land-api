# frozen_string_literal: false

require_relative '../helpers/spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Test gateway' do
  VcrHelper.setup
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.insert
  end

  after do
    VcrHelper.eject
  end

  describe 'Test Indie music api' do
    it 'Happy: should work without errors' do
      _(proc do
        IndieLand::MinistryOfCulture::MusicApi.new.data
      end).must_be_silent
    end
  end

  describe 'Test kktix api' do
    it 'Happy: should work without errors' do
      _(proc do
        IndieLand::MinistryOfCulture::TicketApi.new.data
      end).must_be_silent
    end
  end

  describe 'Test response class' do
    it 'Happy: should work without errors' do
      _(proc do
        IndieLand::MinistryOfCulture::Response.new(HTTP.get(URL))
      end).must_be_silent
    end

    it 'Sad: should raise exception on incorrect api' do
      _(proc do
        IndieLand::MinistryOfCulture::Response.new(HTTP.get(WRONG_URL))
      end).must_raise IndieLand::MinistryOfCulture::Response::Errors::NotFound
    end
  end
end
# rubocop:enable Metrics/BlockLength

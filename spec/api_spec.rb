# frozen_string_literal: false

require_relative 'spec_helper'

describe 'Test' do

  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    # We do not have any token
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Test http response' do
    it 'Happy: should work without errors' do
      _(proc do
        Lobarbon::Response.new(HTTP.get(CONFIG))
      end).must_be_silent
    end

    it 'SAD: should raise exception on incorrect api' do
      _(proc do
        Lobarbon::Response.new(HTTP.get(WRONG_CONFIG))
      end).must_raise Lobarbon::Response::Errors::NotFound
    end
  end

  describe 'Indie music information' do
    before do
      @activities = Lobarbon::MusicApi.new.indie_music_activities
    end

    it 'HAPPY: should get correct number of activities' do
      _(@activities.size).must_equal CORRECT.count
    end

    it 'HAPPY: should identify first activity' do
      _(@activities[0]['title']).must_equal CORRECT[0]['title']
      _(@activities[0]['website']).must_equal CORRECT[0]['website']
      _(@activities[0]['infos'].length).must_equal CORRECT[0]['infos'].length
      _(@activities[0]['infos'][0]['start_time']).must_equal CORRECT[0]['infos'][0]['start_time']
      _(@activities[0]['infos'][0]['end_time']).must_equal CORRECT[0]['infos'][0]['end_time']
      _(@activities[0]['infos'][0]['address']).must_equal CORRECT[0]['infos'][0]['address']
      _(@activities[0]['infos'][0]['location']).must_equal CORRECT[0]['infos'][0]['location']
    end
  end


  describe 'Test indie music json parser with json' do
    it 'Happy: should parse json to the array with predefined format' do
      text = <<~HEREDOC
        [{"version":"1.4","UID":"5f8b4dbdd083a35edcf6bd71","title":"X-FORMOSA 2020 彩虹音樂節","category":"5","showInfo":[{"time":"2020/10/30 00:00:00","location":"","locationName":"皆普新北展演中心","onSales":"Y","price":"","latitude":null,"longitude":null,"endTime":"2020/11/01 00:00:00"}],"showUnit":"","discountInfo":"","descriptionFilterHtml":"","imageUrl":"","masterUnit":[],"subUnit":[],"supportUnit":[],"otherUnit":[],"webSales":"https://www.indievox.com/activity/game/20_iV00614b5","sourceWebPromote":"https://www.indievox.com/activity/detail/20_iV00614b5","comment":"","editModifyDate":"","sourceWebName":"iNDIEVOX","startDate":"2020/10/30","endDate":"2020/11/01","hitRate":0},{"version":"1.4","UID":"5f8b4dbdd083a35edcf6bd72","title":"《今日不插電》vol.1｜王彙筑．曾柏雯．乾淨的房間｜","category":"5","showInfo":[{"time":"2020/10/30 00:00:00","location":"","locationName":"彌聲MixingStudio","onSales":"Y","price":"","latitude":null,"longitude":null,"endTime":"2020/10/30 00:00:00"}],"showUnit":"","discountInfo":"","descriptionFilterHtml":"","imageUrl":"","masterUnit":[],"subUnit":[],"supportUnit":[],"otherUnit":[],"webSales":"https://www.indievox.com/activity/game/20_iV00676a4","sourceWebPromote":"https://www.indievox.com/activity/detail/20_iV00676a4","comment":"","editModifyDate":"","sourceWebName":"iNDIEVOX","startDate":"2020/10/30","endDate":"2020/10/30","hitRate":0}]
      HEREDOC
      indie_music_parser = Lobarbon::Parsers::IndieMusicJsonParser.new(text)
      actual = indie_music_parser.to_data

      _(actual.class.to_s).must_equal 'Array'
      _(actual.length).must_equal 2

      _(actual[0]['title']).must_equal 'X-FORMOSA 2020 彩虹音樂節'
      _(actual[0]['website']).must_equal 'https://www.indievox.com/activity/detail/20_iV00614b5'
      _(actual[0]['infos'].length).must_equal 1
      _(actual[0]['infos'][0]['start_time']).must_equal '2020/10/30 00:00:00'
      _(actual[0]['infos'][0]['end_time']).must_equal '2020/11/01 00:00:00'
      _(actual[0]['infos'][0]['address']).must_equal ''
      _(actual[0]['infos'][0]['location']).must_equal '皆普新北展演中心'
    end
  end
end

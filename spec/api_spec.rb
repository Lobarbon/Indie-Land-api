# frozen_string_literal: false

require_relative 'spec_helper'

describe 'Test Api library' do
  describe 'Test indie music api' do
    it 'Happy: should work without errors' do
      _(proc do
        Lobarbon::MusicApi.new.indie_music_activities
      end).must_be_silent
    end
  end

  describe 'Test indie music json parser' do
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

# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/api.rb'
require_relative '../lib/parsers.rb'

# rubocop:disable Metrics/BlockLength
describe 'Test Api library' do
  describe 'Test basketabll api' do
    it 'Happy: should work without errors' do
      _(proc do
        Lobarbon::SportsApi.new.basketball_tables
      end).must_be_silent
    end
  end

  describe 'Test basketball json parser' do
    it 'Happy: should parse json to the array with predefined format' do
      text = <<~HEREDOC
        {"result":{"p":1,"s":11,"c":2,"r":21,"d":[{"t":1,"id":250394,"no":377,"kdt":1603004700000,"si":442,"cn":["日本","Japan"],"li":8257,"ln":["日本職籃B League","B. League"],"atn":["宇都宮皇者","Utsunomiya Brex"],"apn":[null,null],"htn":["千葉噴射機","Chiba Jets"],"hpn":[null,null],"ms":[{"id":1,"no":1,"name":null,"cs":[[{"id":402,"name":null,"o":"2.05","p":1,"h":null,"l":false},{"id":400,"name":null,"o":"1.50","p":3,"h":null,"l":false}]],"m":3,"ma":8}],"mc":5,"ed":null,"mi":23878961,"lv":false},{"t":1,"id":250473,"no":326,"kdt":1603006200000,"si":442,"cn":["中國","China"],"li":4169,"ln":["中國男子籃球職業聯賽","Chinese Basketball Association(CBA)"],"atn":["山西汾酒","Shanxi Dragons"],"apn":[null,null],"htn":["福建男籃","Fujian Quanzhou Bank"],"hpn":[null,null],"ms":[{"id":1,"no":1,"name":null,"cs":[[{"id":402,"name":null,"o":"2.05","p":1,"h":null,"l":false},{"id":400,"name":null,"o":"1.50","p":3,"h":null,"l":false}]],"m":3,"ma":8}],"mc":5,"ed":null,"mi":23950117,"lv":false}]},"targetUrl":null,"success":true,"error":null,"unAuthorizedRequest":false,"__abp":true}
      HEREDOC
      basketball_parser = Lobarbon::Parsers::BasketballJsonParser.new(text)
      actual = basketball_parser.to_data

      _(actual.class.to_s).must_equal 'Array'
      _(actual.length).must_equal 2

      _(actual[0]['time']).must_equal 1_603_004_700_000
      _(actual[0]['country']).must_equal '日本'
      _(actual[0]['league']).must_equal '日本職籃B League'
      _(actual[0]['away_team']).must_equal '宇都宮皇者'
      _(actual[0]['host_team']).must_equal '千葉噴射機'
    end
  end

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
      _(actual[0]['infos'][0]['location']).must_equal ''
      _(actual[0]['infos'][0]['location_name']).must_equal '皆普新北展演中心'
    end
  end
end
# rubocop:enable Metrics/BlockLength

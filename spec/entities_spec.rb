# frozen_string_literal: false

require_relative 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe 'Test entities class' do
  describe 'Test Session' do
    describe 'Test initialization' do
      it 'should not raise errors if optional fields are nil' do
        _(proc do
          IndieLand::Entity::Session.new(
            session_id: nil,
            event_id: nil,
            start_time: DateTime.parse('2020/10/01 19:00:00'),
            end_time: DateTime.parse('2020/10/01 21:00:00'),
            address: nil,
            place: nil,
            ticket_price: '100'
          )
        end).must_be_silent
      end

      it 'should raise errors if mandotory fields are nil' do
        _(proc do
          IndieLand::Entity::Session.new(
            session_id: nil,
            event_id: nil,
            start_time: nil,
            end_time: DateTime.parse('2020/10/01 21:00:00'),
            address: nil,
            place: nil,
            ticket_price: nil
          )
          IndieLand::Entity::Session.new(
            session_id: nil,
            event_id: nil,
            start_time: DateTime.parse('2020/10/01 19:00:00'),
            end_time: nil,
            address: nil,
            place: nil,
            ticket_price: nil
          )
        end).must_raise Dry::Struct::Error
      end
    end

    describe 'Test to_attr_hash' do
      it 'should return a correct hash result' do
        session = IndieLand::Entity::Session.new(
          session_id: 2,
          event_id: 3,
          start_time: DateTime.parse('2020/10/01 19:00:00'),
          end_time: DateTime.parse('2020/10/01 21:00:00'),
          address: 'address',
          place: 'place',
          ticket_price: '100'
        )

        session_hash = session.to_attr_hash
        _(session_hash[:session_id]).must_equal(2)
        _(session_hash[:event_id]).must_equal(3)
        _(session_hash[:start_time]).must_equal(DateTime.parse('2020/10/01 19:00:00'))
        _(session_hash[:end_time]).must_equal(DateTime.parse('2020/10/01 21:00:00'))
        _(session_hash[:address]).must_equal('address')
        _(session_hash[:place]).must_equal('place')
        _(session_hash[:ticket_price]).must_equal('100')
      end
    end
  end

  describe 'Test Event' do
    before do
      @sessions = [IndieLand::Entity::Session.new(
        session_id: nil,
        event_id: nil,
        start_time: DateTime.parse('2020/10/01 19:00:00'),
        end_time: DateTime.parse('2020/10/01 21:00:00'),
        address: nil,
        place: nil,
        ticket_price: nil
      )]
    end

    describe 'Test initialization' do
      it 'should not raise errors if optional fields are nil' do
        _(proc do
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: 'test123',
            event_name: 'my music concert',
            event_website: 'https://www.test.com',
            description: nil,
            sale_website: 'https://www.riverside.com.tw/',
            source: '河岸留言',
            sessions: @sessions
          )
        end).must_be_silent
      end

      it 'should raise errors if mandatory fields are nil' do
        _(proc do
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: nil,
            event_name: 'my music concert',
            event_website: 'https://www.test.com',
            description: nil,
            sale_website: 'https://www.riverside.com.tw/',
            source: '河岸留言',
            sessions: @sessions
          )
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: 'test123',
            event_name: nil,
            event_website: 'https://www.test.com',
            description: nil,
            sale_website: 'https://www.riverside.com.tw/',
            source: '河岸留言',
            sessions: @sessions
          )
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: 'test123',
            event_name: 'my music concert',
            event_website: nil,
            description: nil,
            sale_website: 'https://www.riverside.com.tw/',
            source: '河岸留言',
            sessions: @sessions
          )
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: 'test123',
            event_name: 'my music concert',
            event_website: 'https://www.test.com',
            description: nil,
            sale_website: nil,
            source: '河岸留言',
            sessions: @sessions
          )
          IndieLand::Entity::Event.new(
            event_id: nil,
            event_uid: 'test123',
            event_name: 'my music concert',
            event_website: 'https://www.test.com',
            description: nil,
            sale_website: 'https://www.riverside.com.tw/',
            source: nil,
            sessions: @sessions
          )
        end).must_raise Dry::Struct::Error
      end
    end

    describe 'Test to_attr_hash' do
      it 'should return a correct result' do
        entity = IndieLand::Entity::Event.new(
          event_id: 3,
          event_uid: 'test123',
          event_name: 'my music concert',
          event_website: 'https://www.test.com',
          description: 'description',
          sale_website: 'https://www.ticket.com',
          source: '河岸留言',
          sessions: @sessions
        )
        entity_hash = entity.to_attr_hash

        _(entity_hash.key?(:event_id)).must_equal(false)
        _(entity_hash[:event_uid]).must_equal('test123')
        _(entity_hash[:event_name]).must_equal('my music concert')
        _(entity_hash[:event_website]).must_equal('https://www.test.com')
        _(entity_hash[:description]).must_equal('description')
        _(entity_hash[:sale_website]).must_equal('https://www.ticket.com')
        _(entity_hash[:source]).must_equal('河岸留言')
        _(entity_hash.key?(:sessions)).must_equal(false)
      end
    end
  end

  describe 'Test UserManager' do
    describe 'create an new user' do
      before do
        @user_manager = IndieLand::Entity::UserManager.instance
        @uid = @user_manager.create_new_user
      end

      it 'should return a uid' do
        _(@uid.class).must_equal(String)
        _(@uid.length).must_equal(36)
      end

      it 'should return true if user exists' do
        _(@user_manager.user_exist?(@uid)).must_equal(true)
      end

      it "should return false if user doesn't exist" do
        _(@user_manager.user_exist?('uid')).must_equal(false)
      end

      it 'should update user login time' do
        before_update_time = @user_manager.login_time(@uid)
        @user_manager.update_user_login_time(@uid)
        after_update_time = @user_manager.login_time(@uid)
        _(before_update_time < after_update_time).must_equal(true)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

# frozen_string_literal: true

# Page object for home page
class RoomPage
  include PageObject

  page_url "#{IndieLand::App.config.APP_HOST}/room/<%= params[:id]%>"

  element(:website_button, visible_text: 'Website')
end

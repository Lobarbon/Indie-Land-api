# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url IndieLand::App.config.APP_HOST

  element(:github_button, visible_text: 'GitHub')

  element(:first_event, id: 'event[0].link')

  element(:first_date, id: 'date[0]')

  def future_date?
    today = DateTime.now.to_date
    [DateTime.parse(first_date, '%Y-%m-%d'), today].min == today
  end
end

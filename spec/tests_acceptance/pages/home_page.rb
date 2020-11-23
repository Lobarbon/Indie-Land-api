# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url IndieLand::App.config.APP_HOST

  element(:github_button, visible_text: 'GitHub')

  element(:first_event, id: 'event[0].link')

  indexed_property(
    :dates,
    [:h2, :date, { id: 'date[%s]' }]
  )

  indexed_property(
    :events,
    [
      [:a, :event_url, { id: 'event[%s].link' }]
    ]
  )

  def last_event
    events[-1]
  end

  def click_github_button
    github_button
  end
end

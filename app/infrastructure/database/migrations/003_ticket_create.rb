# frozen_string_literal: true

Sequel.migration do
    change do
      create_table(:tickets) do

        # foreign_key :event_name, :events
        primary_key :ticket_id
  
        String      :ticket_title
        String      :ticket_url
  
        DateTime     :created_at
        DateTime     :updated_at
      end
    end
  end
  
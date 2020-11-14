# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:sessions) do
      Integer :session_id
      foreign_key :event_id, :events
      primary_key %i[session_id event_id]

      DateTime      :start_time, null: false
      DateTime      :end_time, null: false
      String      :address
      String      :place
      String :ticket_price

      DateTime     :created_at
      DateTime     :updated_at
    end
  end
end

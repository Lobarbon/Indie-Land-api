# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:sessions) do
      primary_key :id
      foreign_key :event_id, :events

      String      :start_time, null: false
      String      :end_time, null: false
      String      :address
      String      :address

      DatTime     :create_at
      DatTime     :update_at
    end
  end
end

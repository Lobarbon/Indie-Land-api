# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      foreign_key :event_id, :events

      String      :comment, null: false

      DateTime     :created_at
      DateTime     :updated_at
    end
  end
end

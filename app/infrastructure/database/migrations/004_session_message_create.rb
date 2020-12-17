# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:messages) do
      Integer :message_id
      foreign_key :event_id, :sessions
      foreign_key :session_id, :sessions
      primary_key %i[message_id event_id session_id]

      String      :message, null: false
      String      :who
      Integer      :like_num
      Integer      :dislike_num

      DateTime     :created_at
      DateTime     :updated_at
    end
  end
end

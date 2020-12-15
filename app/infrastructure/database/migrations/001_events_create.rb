# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id

      String :event_uid, null: false
      String :event_name, null: false
      String :event_website, null: false
      String :event_ticket_website, null: true
      String :description, null: true
      String :sale_website, null: false
      String :source, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

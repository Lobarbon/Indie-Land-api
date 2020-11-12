# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id

      String :event_name, null: false
      String :event_website, null: false
      String :description, null: true
      String :sale_website, null: false
      String :source_name, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

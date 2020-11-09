# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id

      String :event_name, null: false
      String :website, null: false
      String :description, null: true

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

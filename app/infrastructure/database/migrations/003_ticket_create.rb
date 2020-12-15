# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:tickets) do
      primary_key :id

      String      :ticket_title, unique: true
      String      :ticket_url, unique: true

      DateTime     :created_at
      DateTime     :updated_at
    end
  end
end

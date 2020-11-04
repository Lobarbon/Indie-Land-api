# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id
      
      String :name, null: false
      String :ssh_url, null: false
      String :http_url, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

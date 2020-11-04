# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:mebers) do
      primary_key :id
      Integer     :origin_id
      String      :username
      String      :email

      DatTime     :create_at
      DatTime     :update_at
    end
  end
end

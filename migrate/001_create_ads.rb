Sequel.migration do
  change do
    create_table(:ads) do
      primary_key :id
      String :title, null: false
      Text :description, null: false
      String :city, null: false
      Float :lat
      Float :lon
      Bigint :user_id, null: false
      DateTime :created_at, precision: 6, null: false
      DateTime :updated_at, precision: 6, null: false
    end

    add_index :ads, :user_id, name: "index_ads_on_user_id"
  end
end

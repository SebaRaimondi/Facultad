class CreateOffices < ActiveRecord::Migration[5.1]
    def change
        create_table :offices do |t|
            t.string :name, limit: 255
            t.string :phone_number, limit: 30
            t.text :address
            t.boolean :available, default: false

            t.timestamps
        end
    end
end

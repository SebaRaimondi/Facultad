class CreateEmployees < ActiveRecord::Migration[5.1]
    def change
        create_table :employees do |t|
            t.string :name, limit: 150
            t.integer :e_number, limit: 30
            t.references :office, foreign_key: true

            t.timestamps
        end
    end
end

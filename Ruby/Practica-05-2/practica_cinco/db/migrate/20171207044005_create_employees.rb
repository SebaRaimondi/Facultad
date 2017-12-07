class CreateEmployees < ActiveRecord::Migration[5.1]
    def change
        create_table :employees do |t|
            t.string :name, limit: 150, null: false
            t.integer :e_number, null: false
            t.references :office, foreign_key: true
        end
        add_index :employees, :e_number, unique: true
    end
end

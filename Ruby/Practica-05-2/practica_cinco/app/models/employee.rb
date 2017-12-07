class Employee < ApplicationRecord
    belongs_to :office

    validates :name, presence: true, length: { maximum: 150 }
    validates :e_number, presence: true, uniqueness: true

    scope :vacant, -> { where(office: nil) }
    scope :occupied, -> { where.not(office: nil) }
end

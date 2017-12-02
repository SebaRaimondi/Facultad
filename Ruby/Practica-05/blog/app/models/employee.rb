
class Employee < ApplicationRecord
    has_one :office
    scope :vacant, -> { where(office: nil) }
    scope :occupied, -> { where.not(office: nil) }

    validates :name, length: { maximum: 150 }
    validates :e_number, uniqueness: true
    validates :office_id, allow_nil: true
end

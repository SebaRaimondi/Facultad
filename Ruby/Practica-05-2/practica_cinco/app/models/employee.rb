class Employee < ApplicationRecord
    belongs_to :office

    scope :vacant, -> { where(office: nil) }
    scope :occupied, -> { where.not(office: nil) }
end

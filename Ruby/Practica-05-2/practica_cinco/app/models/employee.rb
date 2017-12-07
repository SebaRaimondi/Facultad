class Employee < ApplicationRecord
    belongs_to :office

    validates :name, presence: true, length: { maximum: 255 }
    validates :phone_number, presence: true, length: { maximum: 30 }
    validates :available, presence: true

    scope :vacant, -> { where(office: nil) }
    scope :occupied, -> { where.not(office: nil) }
end

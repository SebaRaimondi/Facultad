
class Office < ApplicationRecord
    has_many :comments, dependent: :destroy
    scope :empty, -> { where(available: true) }

    validates :name, length: { maximum: 255 }
    validates :phone_number, length: { maximum: 30 }, with: /(?<=\s|:)\(?(?:(0?[1-3]\d{1,2})\)?(?:\s|-)?)?((?:\d[\d-]{5}|15[\s\d-]{7})\d+)/
    validates :available, allow_nil: true

    def to_s
        "Name: #{@name}; Phone: #{@phone_number}; Address: #{@address}; Available: #{@available}"
    end
end

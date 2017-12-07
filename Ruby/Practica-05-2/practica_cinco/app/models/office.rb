class Office < ApplicationRecord
    has_many :employee

    validates :name, presence: true, length: { maximum: 255 }
    validates :phone_number, presence: true, length: { maximum: 30 }
    validates :available, presence: true

    validates_with ArgTelValidator

    def to_s
        "Nombre: #{@name}, Telefono: #{@phone_number}, Direccion: #{@address}, Disponible: #{@available}"
    end

    scope :empty, -> { where(available: true) }
end

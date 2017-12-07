class Office < ApplicationRecord
    has_many :employee

    def to_s
        "Nombre: #{@name}, Telefono: #{@phone_number}, Direccion: #{@address}, Disponible: #{@available}"
    end

    scope :empty, -> { where(available: true) }
end

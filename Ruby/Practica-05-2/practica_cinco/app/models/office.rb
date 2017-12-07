class Office < ApplicationRecord
    has_many :employee

    validates :name, presence: true, length: { maximum: 150 }
    validates :e_number, presence: true, uniqueness: true
    validates_with ArgTelValidator

    def to_s
        "Nombre: #{@name}, Telefono: #{@phone_number}, Direccion: #{@address}, Disponible: #{@available}"
    end

    scope :empty, -> { where(available: true) }
end

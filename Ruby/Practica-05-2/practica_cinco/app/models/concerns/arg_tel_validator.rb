class ArgTelValidator < ActiveModel::Validator
    def validate(record)
        regex = /\+54[9]?\d{10}/
        unless regex.match(record.phone_number)
            record.errors.add(:phone_number, 'El formato del telefono es incorrecto')
        end
    end
end

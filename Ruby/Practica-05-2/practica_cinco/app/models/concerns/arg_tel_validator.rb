class ArgTelValidator < ActiveModel::Validator
    def validate(record)
        regex = /^\\(?(\d{3,5})?\\)?\s?(15)?[\s|-]?(4)\d{2,3}[\s|-]?\d{4}$/
        unless regex.match(record.phone_number)
            record.errors.add(:phone_number, 'El formato del telefono es incorrecto')
        end
    end
end

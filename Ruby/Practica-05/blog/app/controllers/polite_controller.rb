class PoliteController < ApplicationController
    def available_locales
        AVAILABLE_LOCALES
    end

    def initialize
        @salutes = %w[Saludo1 Saludo2 Saludo3 Saludo4 Saludo5]
    end

    def salute
        @salutes.sample
    end
end

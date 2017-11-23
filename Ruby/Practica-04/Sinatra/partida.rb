class Partida
    def initialize(word)
        @word = word
        @tries = 3
        @guessed = []
    end

    def summary
        check_win do
            s = "Ahorcado \n\n"
            s << @guessed.to_s << "\n"
            s << 'Fallidos: ' + (3 - @tries).to_s << "\n"
            s << 'Restantes: ' + @tries.to_s << "\n"
            s << 'Palabra: ' + palabra << "\n"
        end
    end

    def palabra
        w = @word
        res = ''
        w.chars.map { |e| res << (@guessed.include?(e.downcase) ? e : ' _ ') }
        res
    end

    def try(char)
        check_win do
            if !@guessed.include?(char) && @word.downcase.include?(char)
                @guessed.push char
            else
                @tries -= 1
            end
        end
    end

    def check_win
        if @tries > 0 && !guessed?
            yield
        elsif guessed?
            "Ganaste!\n"
        else
            "Perdiste :(\n"
        end
    end

    def guessed?
        @word.size == @guessed.size
    end
end

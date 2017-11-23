class MoL
    def call(_env)
        num = rand(1..42)
        code = if num == 42
                   200
               else
                   404
               end
        [code, { 'Content-Type' => 'text/plain' }, [num.to_s]]
    end
end

run MoL.new

# El primer id sera 0, luego 1, 2, 3 etc.

require 'sinatra'

class Producto
    attr_reader :name, :price, :stock
    def initialize(name, price, stock)
        @name = name
        @price = price
        @stock = stock
    end
end

class HealthCheck
    def initialize(app)
        @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)
        status = 200 if env['PATH_INFO'] == '/healthcheck'
        [status, headers, response]
    end
end
use HealthCheck

inv = []

def check_params(*args)
    args.map { |e| return false if params[e].nil? || params[e] == '' }
end

get '/items' do
    res = ''
    inv.map { |p| res << p.name.to_s + ', ' }
    body res.chomp(', ')
end
get '/total/:ids' do |ids|
    ids = ids.split(',')
    res = 0
    ids.map { |id| res += inv[id.to_i].price }
    body res.to_s
end
post '/items' do
    if check_params('nombre', 'precio', 'stock')
        name = params['nombre']
        price = params['precio'].to_i
        stock = params['stock'].to_i
        inv.push(Producto.new(name, price, stock))
        status 201
        body 'El item fue dado de alta'
    else
        status 422
        body 'Faltan datos para dar de alta el item'
    end
end

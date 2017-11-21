require 'bundler'
Bundler.require

class NumberToX
    def initialize(app)
        @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)
        new_response = response.map { |c| c.gsub(/\d/, 'x') }
        [status, headers, new_response]
    end
end

class XCount
    def initialize(app)
        @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)
        headers['X-Xs-Count'] = response.to_s.count('x').to_s
        puts headers
        [status, headers, response]
    end
end

use XCount
use NumberToX

get '/' do
    res = ''
    Sinatra::Application.each_route do |route|
        res << route.verb + ' ' + route.path + '<br>'
    end
    body res
end

get '/mcm/:a/:b' do |a, b|
    a.to_i.lcm(b.to_i).to_s
end

get '/mcd/:a/:b' do |a, b|
    a.to_i.gcd(b.to_i).to_s
end

get '/sum/*' do |nums|
    nums.split('/').map(&:to_i).sum.to_s
end

get '/even/*' do |nums|
    nums.split('/').map(&:to_i).select(&:even?).size.to_s
end

post '/random' do
    rand.to_s
end

post '/random/:lower/:upper' do |lower, upper|
    rand(lower.to_i..upper.to_i).to_s
end

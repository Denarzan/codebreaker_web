require_relative 'codebreaker_web'

class Main
  MIDDLEWARES = [GameRacker, RulesRacker, StatRacker].freeze

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    path = @request.path
    MIDDLEWARES.each { |middleware| return middleware.new(@request).response if middleware::ROUTES.keys.include?(path) }
    Rack::Response.new { |res| res.redirect('/') }
  end
end

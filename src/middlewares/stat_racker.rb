class StatRacker < Raker
  include DBMethods

  ROUTES = {
    '/statistics' => :statistics
  }.freeze

  DIFFICULTY = {
    easy: { attempts: 15, hints: 2 },
    medium: { attempts: 10, hints: 1 },
    hell: { attempts: 5, hints: 1 }
  }.freeze

  def statistics
    Rack::Response.new(render_template('statistics.haml'))
  end
end

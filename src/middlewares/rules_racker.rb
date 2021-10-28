class RulesRacker < Raker
  ROUTES = {
    '/rules' => :rules
  }.freeze

  def rules
    Rack::Response.new(render_template('rules.haml'))
  end
end

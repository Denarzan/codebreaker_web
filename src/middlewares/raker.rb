class Raker
  def initialize(request)
    @request = request
  end

  def redirect(template)
    Rack::Response.new { |res| res.redirect(template) }
  end

  def render_template(template)
    path = File.expand_path("../../../public/#{template}", __FILE__)
    haml = Haml::Engine.new(File.read(path)).render(binding)
    Rack::Response.new(haml)
  end

  def response
    path = @request.path
    public_send(self.class::ROUTES[path])
  end
end

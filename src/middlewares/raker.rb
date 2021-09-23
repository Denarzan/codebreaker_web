class Raker
  def initialize(request)
    @request = request
  end

  def redirect(name)
    Rack::Response.new { |res| res.redirect(name) }
  end

  def render_template(template)
    path = File.expand_path("../../../public/#{template}", __FILE__)
    Haml::Engine.new(File.read(path)).render(binding)
  end

  def response
    path = @request.path
    public_send(self.class::ROUTES[path])
  end
end

class GameRacker < Raker
  include DBMethods

  ROUTES = {
    '/' => :index,
    '/game' => :game_process,
    '/submit_answer' => :compare,
    '/hint' => :hint,
    '/win' => :win,
    '/lose' => :lose,
    '/start' => :start
  }.freeze
  WIN = %w[+ + + +].freeze

  def initialize(request)
    super
    @game = Game.new(@request)
  end

  def start
    return redirect('/') unless @request.params['player_name'] && @request.params['level']

    @game.start_game
    Rack::Response.new(render_template('game.haml'))
  end

  def game_process
    return redirect('/') unless @game.game?

    Rack::Response.new(render_template('game.haml'))
  end

  def index
    return redirect('game') if @game.game?

    Rack::Response.new(render_template('menu.haml'))
  end

  def load_stat_to_file
    YAML.load_file('rating.yml') || []
  rescue Errno::ENOENT
    []
  end

  def compare
    return redirect('/') unless @game.game?
    return redirect('game') if @request.params['number'].nil?

    matches = @game.configure_user_guess
    check_end_game(matches)
  end

  def lose
    return redirect('/') unless @game.game?

    response = render_template('lose.haml')
    @request.session.clear
    response
  end

  def win
    return redirect('/') unless @game.game?

    save_game(@request.session[:codebreaker], @request.session[:user])
    response = render_template('win.haml')
    @request.session.clear
    response
  end

  def hint
    return redirect('/') unless @game.game?

    @game.use_hint
    redirect('game')
  end

  def check_end_game(matches)
    return redirect('win') if matches == WIN
    return redirect('lose') if @request.session[:user].attempts_used == @request.session[:user].attempts_total

    redirect('game')
  end
end

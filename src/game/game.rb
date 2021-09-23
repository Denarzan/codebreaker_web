class Game
  attr_reader :request, :user, :codebreaker

  DIFFICULTY = {
    easy: { attempts: 15, hints: 2 },
    medium: { attempts: 10, hints: 1 },
    hell: { attempts: 5, hints: 1 }
  }.freeze

  GAME_INSTANCES = %i[session_id codebreaker used_hints user guess_output difficulty].freeze

  def initialize(request)
    @request = request
    configure_game
  end

  def configure_user
    @request.session[:user] || case @request.params['level']
                               when 'easy' then NewSuperCodebreaker2021::User.new(@request.params['player_name'], 0)
                               when 'medium' then NewSuperCodebreaker2021::User.new(@request.params['player_name'], 1)
                               when 'hell' then NewSuperCodebreaker2021::User.new(@request.params['player_name'], 2)
                               end
  end

  def start_game
    @codebreaker = @request.session[:codebreaker] || NewSuperCodebreaker2021::Game.new
    @user = configure_user
    @used_hints = @request.session[:used_hints] || []
    setup_session
    puts 'nananananananana'
    puts @user.inspect
    puts @codebreaker.inspect
  end

  def configure_game
    @codebreaker = @request.session[:codebreaker]
    @user = @request.session[:user]
    @used_hints = @request.session[:used_hints]
  end

  def setup_session
    @request.session[:user] = @user
    @request.session[:codebreaker] = @codebreaker
    @request.session[:used_hints] = @used_hints
  end

  def configure_user_guess
    @request.session[:user].attempts_used += 1
    user_code = @request.params['number'].chars.map(&:to_i)
    guess_output = @request.session[:codebreaker].compare_codes(user_code)
    guess_output = ['', '', '', ''].each_with_index.map { |char, index| guess_output[index] || char }
    @request.session[:guess_output] = guess_output
  end

  def hints
    @request.session[:used_hints]
  end

  def use_hint
    hint = @request.session[:codebreaker].take_hint(@request.session[:user], @request.session[:used_hints])
    @request.session[:used_hints].push(hint) if hint
  end

  def game?
    @request.session.include?('codebreaker') && right_attributes?
  end

  def right_attributes?
    includes = @request.session.each.map do |instance|
      GAME_INSTANCES.include? instance[0].to_sym
    end
    includes.all?
  end
end

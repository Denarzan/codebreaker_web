module DBMethods
  FILE = 'rating.yml'.freeze

  def save_game(codebreaker, user)
    codebreaker.save(user, FILE)
  end

  def load_stat_to_file
    YAML.load_file(FILE) || []
  rescue Errno::ENOENT
    []
  end
end

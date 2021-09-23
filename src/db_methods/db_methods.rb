module DBMethods
  def save_game(codebreaker, user)
    codebreaker.save(user, 'rating.yml')
  end

  def load_stat_to_file
    YAML.load_file('rating.yml') || []
  rescue Errno::ENOENT
    []
  end
end

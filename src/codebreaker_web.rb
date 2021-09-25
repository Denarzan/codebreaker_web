require 'rack'
require 'haml'
require 'yaml'
require 'new_super_codebreaker_2021'
require 'i18n'

I18n.load_path << Dir[%w[config locales ** *.yml].join('/')]
I18n.config.available_locales = :en

require_relative 'db_methods/db_methods'
require_relative 'middlewares/raker'
require_relative 'middlewares/game_racker'
require_relative 'middlewares/rules_racker'
require_relative 'middlewares/stat_racker'
require_relative 'game/game'
require_relative 'main'

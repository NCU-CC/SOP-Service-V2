require 'ostruct'
require 'pathname'

# Load environment settings
Config = OpenStruct.new
Config.env = ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development
Config.root = Pathname.new(File.expand_path('../..', __FILE__))

# Load dependencies
require 'bundler'
Bundler.require(:default, Config.env)

require 'yaml'
YAML.load_file('config/config.yml').symbolize_keys.map { |k, v| Config[k] = v }

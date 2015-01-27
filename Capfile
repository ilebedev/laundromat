# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
require 'rvm1/capistrano3'
require 'capistrano/rails/assets'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/secrets_yml'
require 'capistrano/thin'
require 'capistrano/nginx'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'laundromat'
set :deploy_user, 'deploy'

# Repository information
set :repo_url, 'git@github.com:ilebedev/laundromat.git'
set :branch, "master"
set :deploy_via, :remote_cache

# Setup rvm
set :rbenv_type, :system
set :rbenv_ruby, '2.1.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# keep a history of old releases
set :keep_releases, 5

# symlinked files
set :linked_files, %w{config/secrets.yml}

# symlinked directories
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# test cases to be run before deployment
# see lib/capistrano/tasks/run_tests.cap
set :tests, []

# config files to be copied by deploy:setup_config
# see lib/capistrano/tasks/setup_config.cap
set(:config_files, %w(
  nginx.conf
  log_rotation
  monit
))

# config files to be made executable after copying by deploy:setup_config
#set(:executable_config_files, %w(
#  unicorn_init.sh
#))

# files to be symlinked to elsewhere (such as nginx virtualhosts, log rotation, init scripts, etc).
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
  },
  {
    source: "log_rotation",
   link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
  },
  {
    source: "monit",
    link: "/etc/monit/conf.d/#{fetch(:full_app_name)}.conf"
  }
])

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"

  # only allow a deploy with passing tests to deployed
  before :deploy, "deploy:run_tests"

  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations we've added
  after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called automatically.
  after 'deploy:publishing', 'deploy:restart'
end

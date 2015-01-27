# config valid only for Capistrano 3.1
lock '3.2.1'

set :rvm1_ruby_version, '2.1.3'

set :application, 'laundromat'
set :default_stage, 'staging'
set :user, "deploy" # for tmp and deploy folders. Must match deploy user.

# Repository info
set :repo_url, 'git@github.com:ilebedev/laundromat.git'

# Default deploy_to directory is /var/www/my_app
# TODO: figure out how to fetch user name
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :tmp_dir, "/home/#{fetch(:user)}/tmp"
set :deploy_via, :remote_cache
set :copy_compression, :bz2

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :linked_files is []
set :linked_files, %w{config/secrets.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for keep_releases is 5
# set :keep_releases, 5

# nginx configuration
set :stage_domain, ->{ fetch(:domain, 'laundromat.csail.mit.edu') }

set :nginx_domains, "#{fetch(:stage_domain)}"
set :nginx_roles, :app
set :nginx_use_ssl, false
#set :nginx_ssl_certificate, 'my-domain.crt'
#set :nginx_ssl_certificate_path, "#{shared_path}/ssl/certs"
#set :nginx_ssl_certificate_key, 'my-domain.key'
#set :nginx_ssl_certificate_key_path, "#{shared_path}/ssl/private"
set :app_server, true
set :app_server_host, "127.0.0.1"
set :app_server_port, 3000

# Thin configuration
# ... is in /config/thin/#{stage}.yml

namespace :setup do
  desc "Update PGP key for RVM installation"
  task :update_rvm_key do
    on roles(:all) do
      execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
    end
  end

  desc "Install all the infrastructure things"
  task :install do
    on roles(:all) do
      execute :sudo, "apt-get update"
      execute :sudo, "apt-get -y install curl git-core libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev nodejs nginx"
    end
  end
end

namespace :deploy do
  # TODO: remember to bundle install production only gems (--without development test doc)
end

before "rvm1:install:rvm", "setup:update_rvm_key"
after 'setup:install', 'rvm1:install:rvm'
after 'setup:install', 'rvm1:install:ruby'

before 'deploy:start', 'setup'

before 'nginx:start', 'nginx:site:add'
before 'nginx:start', 'nginx:site:enable'
before 'nginx:restart', 'nginx:site:add'
before 'nginx:restart', 'nginx:site:enable'

after 'deploy:finished', 'deploy:restart'

before 'deploy:start', 'nginx:start'
after 'deploy:stop', 'nginx:stop'
before 'deploy:restart', 'nginx:restart'


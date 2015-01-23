# used in case we're deploying multiple versions of the same app side by side.
# Also provides quick sanity checks when looking at filepaths
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, "www.laundromat.csail.mit.edu laundromat.csail.mit.edu"

server 'www.laundromat.csail.mit.edu', user: 'deploy', roles: %w{web app db}, primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

set :rails_env, :production


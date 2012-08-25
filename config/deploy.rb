require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "sampleapp"
set :repository,  "git@github.com:flackend/sampleapp.git"
set :branch, "master"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "flackend.com"                   # Your HTTP server, Apache/etc
role :app, "flackend.com"                   # This may be the same as your `Web` server
role :db,  "flackend.com", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/flackend/#{application}"
set :deploy_via, :remote_cache
set :user, "flackend"
set :use_sudo, false
ssh_options[:port] = 7822

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
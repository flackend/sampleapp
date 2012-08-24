set :application, "sampleapp"
set :repository,  "https://github.com/flackend/sampleapp.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/flackend/#{application}"
set :user, "flackend"
set :password, "1hztb72w"
set :scm_username, "flackend"
# set :scm_passphrase, "a2toGitHub"
set :use_sudo, false
ssh_options[:port] = 7822
default_run_options[:pty] = true
server "flackend.com", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
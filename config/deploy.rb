set :application, "shoebox"
set :domain,      "lounge.local"
set :repository,  "git://github.com/mdub/shoebox.git"
set :use_sudo,    false
set :deploy_to,   "/Users/mdub/WebApps/#{application}"
set :scm,         "git"
set :deploy_via, :remote_cache

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do

  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :after_finalize_update, :except => { :no_release => true } do
    run <<-CMD
      mkdir -p #{shared_path}/cache/photos &&
      rm -f #{latest_release}/public/photos &&
      ln -s #{shared_path}/cache/photos #{latest_release}/public/photos &&
      rm -f #{latest_release}/config/database.yml &&
      ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    CMD
  end

end

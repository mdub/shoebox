set :application, "snap-cache"
set :domain,      "lounge.local"
set :repository,  "git://github.com/mdub/snap-cache.git"
set :use_sudo,    false
set :deploy_to,   "/Users/mdub/WebApps/#{application}"
set :scm,         "git"

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

end

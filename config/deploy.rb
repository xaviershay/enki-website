set :application, "enki-website"
set :repository,  "git://gitorious.org/enki/enki-website.git"
set :user, 'xavier'
set :applicationdir, 'app/enki-website'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/home/#{user}/#{applicationdir}" 
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "enkiblog.com"
role :web, "enkiblog.com"
role :db,  "enkiblog.com", :primary => true

namespace :deploy do
  task :start do
    run "mongrel_rails cluster::start -C #{mongrel_conf}"
  end

  task :stop do
    run "mongrel_rails cluster::stop -C #{mongrel_conf}"
  end

  task :restart do
    run "mongrel_rails cluster::restart -C #{mongrel_conf}"
  end

  task :after_update_code do
    run "cp -f #{shared_path}/config/database.yml #{release_path}/config"
  end
end

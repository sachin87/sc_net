set :domain,  "64.62.143.85"

# name this the same thing as the directory on your server
set :application, "networking"

set :repository, "git@github.com:sachin87/sc_net.git"

server "#{domain}", :app, :web, :db, :primary => true

set :deploy_via, :copy
set :scm, :git
set :branch, "master"
# set this path to be correct on yoru server
set :deploy_to, "/home/#{"railsdev"}/#{application}"
set :use_sudo, false
set :deploy_via, :remote_cache

ssh_options[:port] = 2083
ssh_options[:user] = "railsdev"
ssh_options[:keys] = [File.join(ENV['HOME'],".ssh","server_key")]
ssh_options[:forward_agent] = true

ssh_options[:paranoid] = false

# this tells capistrano what to do when you deploy
namespace :deploy do

  desc <<-DESC
  A macro-task that updates the code and fixes the symlink.
  DESC
  task :default do
    transaction do
      update_code
      symlink
    end
  end
end
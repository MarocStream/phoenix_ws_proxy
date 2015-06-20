# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'phoenix_ws_proxy'
set :repo_url, 'git@github.com:mgwidmann/phoenix_ws_proxy.git'

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/phoenix_ws_proxy'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %W{config/staging.exs config/prod.exs config/prod.secret.exs}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { MIX_ENV: fetch(:stage), PORT: 4000 }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  task :build do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :mix, 'deps.get'
        execute :mix, 'release'
      end
    end
  end

  desc 'Status'
  task :status do
    on roles(:app), in: :sequence, wait: 5 do
      execute release_path.join('bin/phoenix_ws_proxy ping')
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute release_path.join('bin/phoenix_ws_proxy start')
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute release_path.join('bin/phoenix_ws_proxy stop')
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute release_path.join('bin/phoenix_ws_proxy stop')
      execute release_path.join('bin/phoenix_ws_proxy start')
    end
  end

  after :publishing, :restart
  after :updated, :build

end

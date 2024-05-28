lock "~> 3.10"    # 1

set :application, "shared_household_account_book"    # 2
set :repo_url, "https://github.com/KeiSuzukiNishi/shared_household_account_book.git"    # 3
set :linked_files, %w{config/secrets.yml}   # 4
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}   # 5
set :keep_releases, 5   # 6
set :rbenv_ruby, '3.2.2'    # 7
set :log_level, :info   # 8
set :branch, 'main'
# set :rbenv_version, '3.3.0'

after 'deploy:published', 'deploy:seed'   # 9
after 'deploy:finished', 'deploy:restart'   # 10

namespace :deploy do
  namespace :assets do
    task :precompile do
      on roles(:web) do
        within release_path do
          # 既存のプリコンパイルタスク
          execute :rake, 'assets:precompile'

          # 新しく追加するコマンド
          execute :yarn, 'run build:css'
        end
      end
    end
  end
  desc 'Run seed'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
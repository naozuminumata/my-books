# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.14.1'

# Capistranoのログの表示に利用する
set :application, 'my-books'
set :deploy_to, '/var/www/rails/my-books'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, 'git@github.com:naozuminumata/my-books.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.6'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/mybooks.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end


# # capistranoのバージョン固定
# lock '3.14.1'

# # デプロイするアプリケーション名
# set :application, 'my-books'

# # cloneするgitのレポジトリ
# set :repo_url, 'git@github.com:naozuminumata/my-books.git'
# # keys: ['~/.ssh/mybooks.pem'] 

# # deployするブランチ。デフォルトはmasterなのでなくても可。
# set :branch, 'master'

# # deploy先のディレクトリ。 
# set :deploy_to, '/var/www/rails/my-books'

# # シンボリックリンクをはるファイル。
# set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# # シンボリックリンクをはるフォルダ。
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# # コマンド実行時にsudoをつけるか
# set :use_sudo, false

# # 保持するバージョンの個数
# set :keep_releases, 5

# # rubyのバージョン
# set :rbenv_ruby, '2.6.6'

# #出力するログのレベル。
# set :log_level, :debug

# namespace :deploy do
#   desc 'Restart application'
#   task :restart do
#     invoke 'unicorn:restart'
#   end

#   desc 'Create database'
#   task :db_create do
#     on roles(:db) do |host|
#       with rails_env: fetch(:rails_env) do
#         within current_path do
#           execute :bundle, :exec, :rake, 'db:create'
#         end
#       end
#     end
#   end

#   desc 'Run seed'
#   task :seed do
#     on roles(:app) do
#       with rails_env: fetch(:rails_env) do
#         within current_path do
#           execute :bundle, :exec, :rake, 'db:seed'
#         end
#       end
#     end
#   end

#   after :publishing, :restart

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#     end
#   end
# end
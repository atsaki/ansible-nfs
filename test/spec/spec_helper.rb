require 'serverspec'
set :backend, :ssh
set :host, ENV['KITCHEN_HOSTNAME']
set :ssh_options, :user => ENV['KITCHEN_USERNAME'],
                  :port => ENV['KITCHEN_PORT'],
                  :keys => ENV['KITCHEN_SSH_KEY'],
                  :paranoid => false,
                  :user_known_hosts_file => '/dev/null'

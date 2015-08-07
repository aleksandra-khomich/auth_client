namespace :worker do
  desc "Run listener"
  task run_listener: :environment do
    Listener.listen
  end
end

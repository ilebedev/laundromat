namespace :server_setup do
  desc "Setup RVM environment with Rails"
  task :setup_server, roles: :app do
    @ruby_version = "2.1.3"
    install_rvm_ruby

    install_nginx
    install_rvm_passenger
  end

  desc "Install and setup RVM Ruby"
  task :install_rvm_ruby do
    on roles: :app do
      sudo "apt-get update"
      sudo "apt-get install curl bison build-essential zlib1g-dev libssl-dev libreadline5-dev libxml2-dev git-core nodejs libsqlite3-dev -y"
      sh "\\curl -sSL https://get.rvm.io | bash -s stable"
      sh "source ~/.rvm/scripts/rvm"
      sh "rvm reload"
      sh "rvm install #{@ruby_version}"
      sh "rvm --default use #{@ruby_version}"
    end
  end

  desc "Installl Passenger gem and NGINX"
  task :install_pasenger_nginx do
    on roles: :app do
      sh "rvmsudo gem install passenger --no-ri --no-rdoc"
      sh "passenger-install-nginx-module --auto"


    input = ''
    run "rvmsudo passenger-install-apache2-module" do |ch,stream,out|
      next if out.chomp == input.chomp || out.chomp == ''
      print out
      ch.send_data(input = $stdin.gets) if out =~ /(Enter|ENTER)/
    end
    puts <<-EOS
replace PassengerRuby in passenger conf with:
PassengerRuby /usr/local/rvm/bin/passenger_ruby
     EOS
   end
end

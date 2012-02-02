# Create a default admin user
puts "BIKIN ADMIN USER"
AdminUser.create!(:email => 'lophyounee@gmail.com', :password => '107039', :password_confirmation => '107039')

# Create a default provider user
puts "BIKIN USER"
ipul = User.new(:email => 'syaiful.sabril@gmail.com', :password => 'Passw0rd', :password_confirmation => 'Passw0rd', :first_name => "syaiful", :last_name => "sabril", roles: ["employer"])
ipul.skip_confirmation!
ipul.save
adhi = User.new(:email => 'artdvl91@gmail.com', :password => 'Passw0rd', :password_confirmation => 'Passw0rd', :first_name => "adhiguna", :last_name => "sabril", roles: ["provider"])
adhi.skip_confirmation!
adhi.save


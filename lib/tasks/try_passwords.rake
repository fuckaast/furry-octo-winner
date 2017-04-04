task try_passwords: :environment do
	(111457..999999).each do |i|
		Trial.delay.try_with_password(i)
		puts "created delayed job for #{i}"
	end
end
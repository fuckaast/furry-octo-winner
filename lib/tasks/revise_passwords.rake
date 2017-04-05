task revise_passwords: :environment do
	(100000..Trial.last.password.to_i).each do |i|
		if Trial.where(password: i).first.blank?
			Trial.create(password: i, successful: true)
		end
	end
end
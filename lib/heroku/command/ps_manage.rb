module Heroku::Command
	class Ps < Base
		def manage
			type = args.shift
			qty = args.shift
			if type and qty
				heroku.psmanage(extract_app, type, qty)
			else
				display "Usage: heroku ps:manage <type> <qty>"
			end
		end
	end
end

class Heroku::Client
	def psmanage(app, type, qty)
		put("/apps/#{app}/ps/#{type}", :qty => qty)
	end
end

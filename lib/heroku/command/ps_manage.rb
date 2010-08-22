module Heroku::Command
  class Ps < Base
    def manage
      type = args.shift
      qty = args.shift
      if type and qty
        new_qty = heroku.psmanage(extract_app, type, qty)
        display "now running #{new_qty} of #{type}"
      else
        display "usage: heroku ps:manage <pstype> <qty>"
      end
    end

    def index
      ps = heroku.ps(extract_app)

      output = []
      output << "UPID      Process       State               Command"
      output << "--------  ------------  ------------------  ------------------------------"

      ps.each do |p|
        output << "%-8s  %-12s  %-18s  %s" %
          [ p['upid'], p['process'], "#{p['state']} for #{time_ago(p['elapsed']).gsub(/ ago/, '')}", truncate(p['command'], 36) ]
      end

      display output.join("\n")
    end
  end
end

class Heroku::Client
  def psmanage(app, type, qty)
    put("/apps/#{app}/ps/#{type}", :qty => qty)
  end
end

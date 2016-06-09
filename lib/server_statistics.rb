class ServerStatistics
	def self.get
		cpu_rvm_count = `ps -ef | grep rben |wc -l`
		cpu_count = `ps -ef | wc -l`
		uptime = `uptime`

		captures = (`uptime`.match /up (?:(?:(\d+) day?.,)?\s*(\d+):(\d+)|(\d+) min)/)
		  # puts captures.inspect
		  if captures.nil?
		    captures = (`uptime`.match /up (?:(?:(\d+) day?.,)?\s*(\d+) min)/)
		    if captures.nil?
		      captures = (`uptime`.match /up (?:(?:(\d+) day?.,)?\s*(\d+):(\d+) min)/)
		      if captures.nil?
		        captures = (`uptime`.match /up (?:(?:(\d+) day?.,)?\s*(\d+):(\d+))/)
		        # puts captures.captures.inspect
		        captures = captures.captures.insert(3, nil)
		      else
		        # puts captures.captures.inspect
		        captures = captures.captures.insert(3, nil)
		      end
		    else
		      # puts captures.inspect
		      captures = captures.captures.insert(1, nil).insert(3, nil)
		    end

		  else
		    captures = captures.captures
		  end
		elapsed_seconds = captures.zip([86440, 3600, 60, 60]).inject(0) do |total, (x,y)|
		    total + (x.nil? ? 0 : x.to_i * y)
		end
		up = Time.now - elapsed_seconds
		memory_usage = `free -m | awk '/Mem:/ {total=$2}  /Mem:/ {used=$3} END {print used/total*100}'`
		swap_to_ram_usage = `free -m |    awk '/Mem:/ { total=$2 } /Swap:/ { used=$3 } END { print used/total*100}'`
		cpu_usage = uptime.split.last(3).join(' ')
		free_hdd = (100 - `df -h | awk '/dev/ {print $5}'`.split("\n")[0].to_i).to_s + '%'

		hash = {
		  cpu_count: cpu_count.chomp,
		  uptime: up,
		  cpu_rvm_count: cpu_rvm_count.chomp,
		  cpu_usage: cpu_usage,
		  memory_usage: memory_usage.to_f.round(2).to_s,
		  swap_to_ram_usage: swap_to_ram_usage.to_f.round(2).to_s,
		  checked: Time.now,
		  free_disk: free_hdd
		}

		return hash
	end
end
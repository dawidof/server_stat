# Server Statistics
Collect server information

# Getting started

You can add it to your Gemfile with:
> gem 'server_stat'

# How to use
> ServerStatistics.get

Will return 
> {:cpu_count=>"104", :uptime=>2016-06-04 07:43:19 +0100, :cpu_rvm_count=>"3", :cpu_usage=>"0.00, 0.01, 0.05", :memory_usage=>"86.53", :swap_to_ram_usage=>"135.1", :checked=>2016-06-08 18:54:59 +0100, :free_disk=>"37%"}

Tested on CentOS 7

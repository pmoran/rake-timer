RakeTimer
==============

Times how long each Rake tasks takes. If your Rake build starts to get too long, it can be useful to quickly see how long each is taking. It can also be useful to track Tasks over time.

Usage
------------
In your Rakefile, add:

	require 'rake-timer'
	time_tasks

Output
------------
By default, time stats are written to the console. Optionally, you can write (append) to a CSV file (in reports/rake-timer.csv), which can easily be read by a charting library such as [Highcharts](http://highcharts.com/)

Even more optionally, you can output results to the very nice [statsd](https://github.com/etsy/statsd). Each task gets its own time-based set of graphs, so you can see how your build time is affected over, well time.

A full set of configuration options would be:

	time_tasks :to => [:csv, :statsd], :unit => :milliseconds, :host => 'localhost', :port => 8125
	
Host and port are the statsd daemon you prepared earlier.

Installation
------------

RakeTimer is packaged as a Gem.  Install with:

    gem install rake-timer

Copyright
---------

Copyright (c) 2011 Peter Moran. See LICENSE for details.
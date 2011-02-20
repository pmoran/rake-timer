require 'socket'
require File.expand_path(File.dirname(__FILE__) + '/rake/task')

# time_tasks :to => [:csv, :statsd], :unit => :milliseconds, :host => 'localhost', :port => 8125
def time_tasks(options = {})
  Thread.current[:time_options] = options
end

class RakeTimer

  class << self

    def time(task_name)
      start = Time.now
      result = yield
      record(task_name, Time.now - start)
      result
    end

    def record(task_name, time)
      unit = config[:unit] || :milliseconds
      if unit == :seconds
        output_time = time
        puts "#{task_name} took #{sprintf("%.3f", output_time)} seconds"
      else
        output_time = time * 1000
        puts "#{task_name} took #{output_time} milliseconds"
      end
      output_options = config[:to] || {}
      as_csv(task_name, output_time) if output_options.include? :csv
      as_statsd(task_name, time) if output_options.include? :statsd
    end

    def as_csv(task_name, time)
      File.open("reports/rake-timer.csv", 'a') do |f|
        f.write("#{task_name}, #{time * 1000}\n")
      end
    end

    def as_statsd(task_name, time)
      u = UDPSocket.new
      u.connect(config[:host], config[:port])
      task = task_name.gsub(/:/, '-')
      msg = "build.#{task}:#{time}|ms"
      u.send(msg, 0)
    end

    def config
      Thread.current[:time_options]
    end

  end

  private_class_method :config, :as_statsd, :as_csv, :record

end

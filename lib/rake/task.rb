module Rake

  class Task

    alias_method :old_execute, :execute

    def execute(*args)
      RakeTimer.time(self.name) { old_execute(*args) }
    end

  end

end


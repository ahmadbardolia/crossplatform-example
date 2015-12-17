module MyProcess
  module Helper

    if RUBY_PLATFORM =~ /mswin|mingw32|windows/
      require 'win32ole'
    end

    def is_process_running?(process_name)
      return false
    end

  end
end

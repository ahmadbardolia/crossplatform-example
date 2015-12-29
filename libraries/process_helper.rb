require 'Win32API' if Chef::Platform.linux?
require 'win32/registry' if Chef::Platform.windows?
require 'win32ole' if Chef::Platform.windows?

module MyProcess
  module Helper

    def is_process_running?(process_name)
      return false
    end

  end
end

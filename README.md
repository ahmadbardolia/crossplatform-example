# Cross Platform Cookbook Development

## Synopsis of Problem
Cookbook metadata.rb does not provide a way to optionally depend on another cookbook based upon its platform architecture.  Thus is it tempting to write platform specific cookbooks and use other logic to affect inclusion of the cookbook in a node's run_list.

## Example Scenario
Often as you write cookbooks for your organization you may encounter a situation where the initial target scope of infrastructure platform changes. For instance, perhaps initially your entire environment was comprised of Windows nodes but now you're adding Linux systems to the environment. You have a couple of options:

1. Write new library cookbooks for the Linux systems
2. Re-factor the existing (Windows) library cookbooks for both platforms

Since cookbook duplication (inadvertent or purposeful duplication) can lead to maintenance nightmares, poor factoring, and logical contradictions (see [DRY](http://c2.com/cgi/wiki?DontRepeatYourself)), the second option is superior in most cases.

However, this option can present an immediate problem if your existing Windows library cookbook contains a library like this and you attempt to include the cookbook in a Linux node's run_list:

```
# libraries/process_helper.rb

require 'win32/registry'
require 'win32ole'

module MyLib
  module Helper

    ...
  end
end
```

```
Compiling Cookbooks...

================================================================================
Recipe Compile Error in libraries/process_helper.rb
================================================================================

LoadError
---------
cannot load such file -- win32ole
```

As the node attempts to converge (compile then execution stage), the compile phase fails since the required ruby libraries do not exist on the system.

## Solutions

Since cookbook libraries are just ruby and they have access to the Chef namespace including helper functions, we can leverage platform detection logic and wrap the problem areas in conditional statements.

Thus are require statements change to this:

```
require 'win32/registry' Chef::Platform.windows?
require 'win32ole' if Chef::Platform.windows?
```

This simple pattern allows the compile phase to complete successfully and the execution phase begins.

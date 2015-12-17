#
# Cookbook Name:: python
# Recipe:: install-windows
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Application.fatal! "[python::install-windows] unsupported platform family: #{node[:platform_family]}" if platform?('linux')

::Chef::Recipe.send(:include, MyProcess::Helper)
::Chef::Recipe.send(:include, MyApplication::Helper)

# Do stuff..
Chef::Log.warn "Installing Windows python.." if ! is_process_running?('python.exe')

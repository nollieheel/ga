#
# Cookbook Name:: basic-cb
# Recipe:: prep_packages
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'vim'
package 'curl'
package 'wget'

include_recipe 'build-essential'
include_recipe 'git'

# I might be doing some edit on an ubuntu machine
case node['platform']
when 'ubuntu'
  file "#{Dir.home('ubuntu')}/.vimrc" do
    owner 'ubuntu'
    group 'ubuntu'
    mode 0644
    content "set ts=2 sw=2\nset expandtab"
    action :create_if_missing
  end
end

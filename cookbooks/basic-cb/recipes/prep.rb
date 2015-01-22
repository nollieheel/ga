#
# Cookbook Name:: basic-cb
# Recipe:: prep 
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform']
when 'debian', 'ubuntu'
  execute 'do_update_machine_deb' do
    command 'apt-get update && apt-get -y upgrade'
  end
when 'rhel', 'centos', 'fedora'
  execute 'do_update_machine_rh' do
    command 'yum -y update'
  end
end

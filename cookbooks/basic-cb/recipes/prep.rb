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
    command 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y '\
            '-o Dpkg::Options::="--force-confnew" --force-yes upgrade'
  end

  rebfile1 = '/var/run/reboot-required'
  rebfile2 = rebfile1 + '.pkgs'

  reboot 'reboot_after_upgrade' do
    action :reboot_now
    reason 'Node needs restart before continuing. Please re-run script later.'
    only_if { ::File.exist?(rebfile1) || ::File.exist?(rebfile2) }
  end
when 'rhel', 'centos', 'fedora'
  execute 'do_update_machine_rh' do
    command 'yum -y update'
  end
end

name             'chef-zabbix'
maintainer       'nollieheel'
maintainer_email 'iskitingbords@gmail.com'
license          'All rights reserved'
description      'Installs/Configures chef-zabbix'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt', '~> 2.7.0'
depends 'simple_iptables', '~> 0.7.1'

supports 'redhat'
supports 'centos'

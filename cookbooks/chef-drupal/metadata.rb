name             'chef-drupal'
maintainer       'nollieheel'
maintainer_email 'iskitingbords@gmail.com'
license          'All rights reserved'
description      'Installs/Configures chef-drupal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/ga/tree/chef-drupal/cookbooks/chef-drupal'
issues_url       'https://github.com/nollieheel/ga/issues'
version          '0.1.1'

depends 'tar', '~> 0.6.0'
depends 'cron', '~> 1.6.1'

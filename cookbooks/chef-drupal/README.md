chef-drupal Cookbook
====================
Cookbook for installing Drupal, taken mostly the supermarket drupal cookbook (https://github.com/promet/drupal-cookbook). However, that cookbook installs everything, including the apache webserver, in one recipe. 

This will allow users to installs portions of the drupal app and customize them if necessary, such as using Nginx as webserver, or MariaDB as DB.

Additionally, it will be up to the user to install the following required software for Drupal to actually run:
```
php-mysql
php-cli
php-dom (pre-installed with PHP in debian, provided in php-xml in rhel/fedora)
postfix
```

TODO:
The DB recipes.

Requirements
------------
#### cookbooks
- `tar`
- `cron`

#### platforms
- Non-windows platforms only

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### chef-drupal::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef-drupal']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### chef-drupal::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `chef-drupal` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-drupal]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors

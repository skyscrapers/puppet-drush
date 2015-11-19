puppet-drush
===============

[![Build
Status](https://secure.travis-ci.org/previousnext/puppet-drush.png)](http://travis-ci.org/previousnext/puppet-drush)

This module installs [Drush](http://www.drush.org//), a command line shell and
Unix scripting interface for Drupal.

Installation
------------

Using the Puppet Module Tool, install the
[`previousnext/drush`](http://forge.puppetlabs.com/previosnext/drush) module by
running the following command:

    puppet module install previousnext/drush

Otherwise, clone this repository and make sure to install the proper
dependencies ([`puppet-wget`](https://github.com/maestrodev/puppet-wget)):

    git clone git://github.com/previousnext/puppet-drush.git modules/drush

**Important:** the right `puppet-wget` module is
[maestrodev/puppet-wget](https://github.com/maestrodev/puppet-wget). You should
**not** use any other `puppet-wget` module. Example42's module won't work for
instance. So, please, run the following command:

    git clone git://github.com/maestrodev/puppet-wget.git modules/wget


Usage
-----

Include the `drush` class:

    include drush

You can specify the command name you want to get, and the target directory (aka
where to install Composer):

    class { 'drush':
      command_name => 'drush',
      target_dir   => '/usr/local/bin'
    }

You can specify a particular `user` that will be the owner of the Composer
executable:

    class { 'drush':
      user => 'foo',
    }


Running the tests
-----------------

Install the dependencies using [Bundler](http://gembundler.com):

    BUNDLE_GEMFILE=.gemfile bundle install

Run the following command:

    BUNDLE_GEMFILE=.gemfile bundle exec rake spec


License
-------

puppet-drush is released under the  License. See the bundled LICENSE file
for details.


Acknowledgement
---------------

puppet-drush is very heavily based on [puppet-composer](https://github.com/willdurand/puppet-composer) by William Durand.

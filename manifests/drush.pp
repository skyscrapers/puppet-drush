# = Class: drush::drush
#
# == Parameters:
#
# [*verion*]
#   The version of drush to install.
#
# [*target_dir*]
#   Where to install the drush package.
#
# [*link_name*]
#   The full path for the drush symlink.
#
# [*user*]
#   The owner of the drush directory.
#
# == Example:
#
#   include drush::drush
#
#   class { 'drush':
#     'version'    => '7',
#     'target_dir' => '/opt',
#     'link_name'  => '/usr/local/bin/drush',
#     'user'       => 'root',
#   }
#
class drush::drush (
  $version    = $drush::params::version,
  $target_dir = $drush::params::target_dir,
  $link_name  = $drush::params::link_name,
  $user       = $drush::params::user,
) inherits drush::params {

  # Make sure that the target dir exists and is writable by the user.
  file { "${target_dir}/drush-${version}":
    ensure => directory,
    owner  => $user,
    mode   => '0755'
  }

  # Grab drush via composer.
  exec { "drush-install-${version}":
    command     => "composer --no-dev require drush/drush ${version}",
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd         => "${target_dir}/drush-${version}",
    environment => ["COMPOSER_HOME=${target_dir}/drush-${version}"],
    user        => $user,
    require     => [
      Class['composer']
    ]
  }

  # Create a symlink.
  file { $link_name:
    ensure  => link,
    owner   => $user,
    target  => "${target_dir}/drush-${version}/vendor/bin/drush",
    require => Exec["drush-install-${version}"]
  }
}

# = Class: drush
#
# == Parameters:
#
# [*verion*]
#   The version of drush to install.
#
# [*target_dir*]
#   Where to install the drush package.
#
# [*command_name*]
#   The full path for the drush symlink.
#
# [*user*]
#   The owner of the drush directory.
#
# == Example:
#
#   include drush
#
#   class { 'drush':
#     'version'      => '7',
#     'target_dir'   => '/opt',
#     'command_name' => '/usr/local/bin/drush',
#     'user'         => 'root',
#   }
#
class drush (
  $version      = 'UNDEF',
  $target_dir   = 'UNDEF',
  $command_name = 'UNDEF',
  $user         = 'UNDEF',
) {

  include drush::params

  $drush_version = $version ? {
    'UNDEF' => $::drush::params::version,
    default => $version
  }

  $drush_target_dir = $target_dir ? {
    'UNDEF' => $::drush::params::target_dir,
    default => $target_dir
  }

  $drush_command_name = $command_name ? {
    'UNDEF' => $::drush::params::command_name,
    default => $command_name
  }

  $drush_user = $user ? {
    'UNDEF' => $::drush::params::user,
    default => $user
  }

  # Make sure that the target dir exists and is writable by the user.
  file { "${drush_target_dir}/drush-${drush_version}":
    ensure => directory,
    owner  => $drush_user,
    mode   => '0755'
  }

  # Grab drush via composer.
  exec { "drush-install-${drush_version}":
    command     => "composer --no-dev require drush/drush ${drush_version}",
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd         => "${drush_target_dir}/drush-${drush_version}",
    environment => ["COMPOSER_HOME=${drush_target_dir}/drush-${drush_version}"],
    user        => $drush_user,
    require     => [
      Class['composer']
    ]
  }

  # Create a symlink.
  file { $drush_command_name:
    ensure  => link,
    owner   => $drush_user,
    target  => "${drush_target_dir}/drush-${drush_version}/vendor/bin/drush",
    require => Exec["drush-install-${version}"]
  }
}

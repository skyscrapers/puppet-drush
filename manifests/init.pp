# = Class: drush
#
# == Parameters:
#
# [*target_dir*]
#   Where to install the drush executable.
#
# [*command_name*]
#   The name of the drush executable.
#
# [*user*]
#   The owner of the drush executable.
#
# == Example:
#
#   include drush
#
#   class { 'drush':
#     'target_dir'   => '/usr/local/bin',
#     'user'         => 'root',
#     'command_name' => 'drush',
#     'auto_update'  => true
#   }
#
class drush (
  $target_dir   = 'UNDEF',
  $command_name = 'UNDEF',
  $user         = 'UNDEF',
) {

  include drush::params

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

  wget::fetch { 'drush-install':
    source      => $::drush::params::phar_location,
    destination => "${drush_target_dir}/${drush_command_name}",
    execuser    => $drush_user,
  }

  exec { 'drush-test-download':
    command => "php ${drush_target_dir}/${drush_command_name} core-status",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $drush_target_dir,
    user    => $drush_user,
    require => Wget::Fetch['drush-install'],
  }

  exec { 'drush-fix-permissions':
    command => "chmod a+x ${drush_command_name}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $drush_target_dir,
    user    => $drush_user,
    unless  => "test -x ${drush_target_dir}/${drush_command_name}",
    require => Exec['drush-test-dnwload'],
  }

}

# A master class for drush.

class drush {

  # We need composer.
  include composer
  class { 'composer':
    'target_dir'   => '/usr/local/bin',
    'user'         => 'root',
    'command_name' => 'composer',
  }

  # Make all the hiera-defined drushes, my pretties!
  $drush = hiera_hash('drush', false)
  if $drush {
    create_resources(drush::drush, $drush)
  }
}

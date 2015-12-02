# A master class for drush.

class drush {
  $drush = hiera_hash('drush', false)
  if $drush {
    create_resources(drush::drush, $drush)
  }
}

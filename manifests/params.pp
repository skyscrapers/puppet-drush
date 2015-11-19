# = Class: drush::params
#
# This class defines default parameters used by the main module class drush.
# Operating Systems differences in names and paths are addressed here.
#
# == Variables:
#
# Refer to drush class for the variables defined here.
#
# == Usage:
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes.
#
class drush::params {
  $phar_location = 'https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar'
  $target_dir    = '/usr/local/bin'
  $command_name  = 'drush'
  $user          = 'root'
}

# # conntrackd::package
#
# @summary This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
# @api private
#
# This class may be imported by other classes to use its functionality:
#   class { 'conntrackd::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
# @author Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd::package {
  assert_private()

  #### Package management

  # set params: in operation
  if $conntrackd::ensure == 'present' {

    $package_ensure = $conntrackd::autoupgrade ? {
      true  => 'latest',
      false => 'present',
    }

  # set params: removal
  } else {
    $package_ensure = 'purged'
  }

  # action
  package { $conntrackd::package:
    ensure => $package_ensure,
  }

}

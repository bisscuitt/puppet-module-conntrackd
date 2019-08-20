# Remove any trace of conntrackd

class { 'conntrackd':
  ensure       => 'absent',
}

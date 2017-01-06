# == Class: conntrackd::params
#
# This class exists to
# 1. Declutter the default value assignment for class parameters.
# 2. Manage internally used module variables in a central place.
#
# Therefore, many operating system dependent differences (names, paths, ...)
# are addressed in here.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class is not intended to be used directly.
#
#
# === Links
#
# * {Puppet Docs: Using Parameterized Classes}[http://j.mp/nVpyWY]
#
#
# === Authors
#
# * Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd::params {

  #### Default values for the parameters of the main module class, init.pp

  # ensure
  $ensure = 'present'

  # autoupgrade
  $autoupgrade = false

  # service status
  $status = 'enabled'

  #### Internal module values

  # packages
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Fedora', 'Scientific': {
      $package = [ 'conntrack-tools' ]
    }
    'Debian', 'Ubuntu': {
      $package = [ 'conntrackd' ]
    }
    default: {
      fail("\"${module_name}\" provides no package default value for \"${::operatingsystem}\"")
    }
  }

  # service parameters
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Fedora', 'Scientific': {
      $service_name       = 'conntrackd'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
      $service_status     = '/usr/bin/pgrep conntrackd >/dev/null'
    }
    'Debian', 'Ubuntu': {
      $service_name       = 'conntrackd'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
      $service_status     = '/usr/bin/pgrep conntrackd >/dev/null'
    }
    default: {
      fail("\"${module_name}\" provides no service parameters for \"${::operatingsystem}\"")
    }
  }

  # location of configuration file
  $config_dir      = '/etc/conntrackd'
  $config_filename = 'conntrackd.conf'

  # Configuration file parameters
  # -- Set the hashlimit to be double the sysctl value of net.nf_conntrack_max
  #    uses custom fact defined in this module
  if $::nf_conntrack_max {
      $hashlimit = $::nf_conntrack_max * 2
  } else {
      $hashlimit = 131072
  }

  $nice = -1
  $hashsize = 32768
  $logfile = 'off'
  $syslog = 'on'
  $lockfile = '/var/lock/conntrack.lock'
  $sock_path = '/var/run/conntrackd.ctl'
  $sock_backlog = 20
  $ignore_ips_ipv4 = [ '127.0.0.1', '192.168.0.1', '10.1.1.1' ]
  $ignore_ips_ipv6 = [ '::1' ]
  $tcp_flows = [ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]

  $netlinkbuffersize = 2097152
  $netlinkbuffersizemaxgrowth = 8388608
  $netlinkoverrunresync = 'on'
  $netlinkeventsreliable = 'Off'
  $pollsecs = undef
  $eventiterationlimit = 100

  $sync_mode = 'FTFW'
  $resend_queue_size = 131072
  $ack_window_size = 300
  $disable_external_cache = 'Off'
  $disable_internal_cache = 'Off'
  $refresh_time = 15
  $cache_timeout = 180
  $commit_timeout = 180
  $purge_timeout = 60

  $protocol = 'Multicast'
  $interface = undef
  $ipv4_address = '225.0.0.50'
  $ipv4_interface = undef
  $mcast_group = '3780'
  $sndsocketbuffer = 1249280
  $rcvsocketbuffer = 1249280
  $checksum = 'on'
  $udp_ipv6_address = undef
  $udp_ipv4_dest = undef
  $udp_ipv6_dest = undef
  $udp_port = 3780

  $filter_accept_protocols = [ 'TCP', 'SCTP', 'DCCP' ]

  $tcp_window_tracking = 'Off'
  $track_tcp_states = [ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]

  $scheduler_type = 'FIFO'
  $scheduler_priority = '99'

  $stats_logfile = undef
  $stats_netlink_reliable = 'Off'
  $stats_syslog = undef

}

# == Class: conntrackd::config
#
# This class exists to coordinate all configuration for the conntrackd daemon
#
# === Parameters
#
##
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. 
#   Default: <tt>present</tt>.
#
# [*autoupgrade*]
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Default: <tt>false</tt>.
#
# [*status*]
#   String to define the status of the service. Possible values:
#   * <tt>enabled</tt>: Service is running and will be started at boot time.
#   * <tt>disabled</tt>: Service is stopped and will not be started at boot
#     time.
#   * <tt>running</tt>: Service is running but will not be started at boot time.
#     You can use this to start a service on the first Puppet run instead of
#     the system startup.
#   * <tt>unmanaged</tt>: Service will not be started at boot time and Puppet
#     does not care whether the service is running or not. 
#   Default: <tt>enabled</tt>. 
#
# [*nice*]
#   integer: Nice value of the ocnntrackd process
#   range: <tt>-19</tt> to <tt>+19</tt>
#   Default: <tt>-1</tt>
#
# [*hashsize*]
#   integer: Number of buckets in the cache hashtable.
#   Default: <tt>32768</tt>
#
# [*hashlimit*]
#   integer: Maximum number of conntracks in table
#   Default: <tt>2x the value of /proc/sys/net/netfilter/nf_conntrack_max</tt>
#
# [*logfile*]
#   string:  fully qualified path to the logfile (directory must exist and be writable) or 'Off'
#   values:  <tt>on</tt>, <tt>off</tt>, <tt><path to file></tt>
#   Default: <tt>off</tt>
#
# [*syslog*]
#   string:  enable syslog logging
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt> 
#   Default: <tt>on</tt>
#
# [*lockfile*]
#   string:  fully qualified path to the lockfile
#   Default: <tt>/var/lock/conntrack.lock</tt>
#
# [*sock_path*]
#   string:  fully qualified path to the UNIX socket used for configuration
#   Default: <tt>/var/run/conntrackd.ctl</tt>
#
# [*sock_backlog*]
#   integer: sets the blacklog ofr the UNIX socket
#   Default: <tt>20</tt>
#
# [*ignore_ips_ipv4*]
#   array:   list of IPv4 addresses to ignore, this should include our own address
#   Default: <tt>[ '127.0.0.1', '192.168.0.1', '10.1.1.1' ]</tt>
#
# [*ignore_ips_ipv6*]
#   array:   list of IPvr addresses to ignore, this should include our own addresses
#   Default: <tt>[ '::1' ]</tt>
#
# [*tcp_flows*]
#   array:   list of flows to monitor
#   allowed: 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT'
#   Default: <tt>[ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]</tt>
#
# [*netlinkbuffersize*]
#   integer: Netlink event socket buffer size
#   Default: <tt>2097152</tt>
#
# [*netlinkbuffersizemaxgrowth*]
#   integer: The daemon doubles the size of the netlink event socket buffer size
#            if it detects netlink event message dropping . This clause sets the
#            maximum buffer size growth that can be reached.
#   Default: <tt>8388608</tt>
#
# [*netlinkoverrunresync*]
#   boolean: If the daemon detects that Netlink is dropping state-change events,
#            it automatically schedules a resynchronization against the Kernel
#            after 30 seconds (default value)
#   Default: <tt>on</tt>
#
# [*netlinkeventsreliable*]
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#   Default: <tt>Off</tt>
#
# [*pollsecs*]
#   integer: By default, the daemon receives state updates following an
#            event-driven model. You can modify this behaviour by switching to
#            polling mode with the PollSecs clause.
#   Default: <tt>Off</tt>
#
# [*eventiterationlimit*]
#   integer: The daemon prioritizes the handling of state-change events coming
#            from the core. With this clause, you can set the maximum number of
#            state-change events (those coming from kernel-space) that the daemon
#            will handle after which it will handle other events coming from the
#            network or userspace
#   Default: <tt>100</tt>
#
# [*sync_mode*]
#   string:  The syncronisation mode to use
#   values:  one of: <tt>FTFW</tt>, <tt>NOTRACK</tt> or <tt>ALARM</tt>
#   Default: <tt>FTFW</tt>
#
# [*resend_queue_size*]
#   integer: Size of the resend queue (in objects)
#   Default: <tt>131072</tt>
#
# [*ack_window_size*]
#   integer: acknowledgement window size. If you decrease this
#            value, the number of acknowlegdments increases
#   Default: <tt>300</tt>
#
# [*disable_external_cache*]
#   boolean: This clause allows you to disable the external cache. Thus,
#            the state entries are directly injected into the kernel
#            conntrack table.
#   Default: <tt>Off</tt>
#
#  [*refresh_time*]
#   integer: ALARM Mode: If a conntrack entry is not modified in <= 15 seconds, then
#            a message is broadcasted.
#   Default: <tt>15</tt>
#
#  [*cache_timeout*]
#   integer: If we don't receive a notification about the state of 
#            an entry in the external cache after N seconds, then
#            remove it.
#   Default: <tt>180</tt>
#
#  [*commit_timeout*]
#   integer: This parameter allows you to set an initial fixed timeout
#            for the committed entries when this node goes from backup
#            to primary.
#   Default: <tt>180</tt>
#
#  [*purge_timeout*]
#   integer: If the firewall replica goes from primary to backup,
#            the conntrackd -t command is invoked in the script. 
#            This command schedules a flush of the table in N seconds.
#   Default: <tt>60</tt>
#
#  [*protocol*]
#   string:  The protocol to use for syncing.
#   values:  <tt>Multicast</tt> or <tt>UDP</tt> 
#   Default: <tt>Multicast</tt>
#
#  [*interface*]
#   string:  The dedicated physical interface to use for talking to the other host.
#   value:   <tt><interface name></tt>
#   Default: <tt>undef</tt>
#
#  [*ipv4_address*]
#   string:  Multicast mode only: The multicast address to commuincate over
#   value:   *Must* be set for Multicast mode: <tt><multicast address></tt>
#   Default: <tt>255.0.0.50</tt>
#
#  [*ipv4_interface*]
#   string:  The ip address to bind to for multicast and UDP connections.
#   value:   *Must* be set for Multicast or UDP mode: <tt><ipaddress></tt>
#   Default: <tt>undef</tt>
#
#  [*mcast_group*]
#   integer: The multicast group to use for Multicast mode
#   Default: <tt>3780</tt>
#
#  [*sndsocketbuffer*]
#   integer: The multicast sender uses a buffer to enqueue the packets
#            that are going to be transmitted.
#   Default: <tt>1249280</tt>
#
#  [*rcvsocketbuffer*]
#   integer: The multicast receiver uses a buffer to enqueue the packets
#            that the socket is pending to handle.
#   Default: <tt>1249280</tt>
#
#  [*checksum*]
#   integer: Enable/Disable message checksumming.
#   Default: <tt>on</tt>
#
#  [*udp_ipv6_address*]
#   string:  The IPv6 interface address to bind to in UDP mode
#   Default: <tt>undef</tt>
#
#  [*udp_ipv4_dest*]
#   string:  The IPv4 interface of the other node when UDP is enabled
#   Default: <tt>undef</tt>
#
#  [*udp_ipv6_dest*]
#   string:  The IPv6 interface of the other node when UDP is enabled
#   Default: <tt>undef</tt>
#
#  [*udp_port*]
#   integer: The UDP port to communicate over (should be the same on both nodes)
#   Default: <tt>3780</tt>
#
#  [*filter_accept_protocols*]
#   array:   Accept only certain protocols
#   values:  <tt>TCP</tt>, <tt>SCTP</tt>, <tt>DCCP</tt>, <tt>UDP</tt>, <tt>ICMP</tt>, <tt>IPv6-ICMP</tt>
#   Default: <tt>[ 'TCP', 'SCTP', 'DCCP' ]</tt>
#
#  [*tcp_window_tracking*]
#   boolean: TCP state-entries have window tracking disabled by default,
#            you can enable it with this option.
#   Default: <tt>Off</tt>
#
#  [*track_tcp_states*]
#   array:   The specific TCP states to sync
#   Default: <tt>[ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]</tt>
#
#  [*scheduler_type*]
#   string:  Select a different scheduler for the daemon. 
#            See man sched_setscheduler(2) for more information. Using a RT
#            scheduler reduces the chances to overrun the Netlink buffer.
#   values:  <tt>RR</tt>, <tt>FIFO</tt>
#   Default: <tt>FIFO</tt>
#
#  [*scheduler_priority*]
#   integer: scheduler process priority
#   range:   <tt>0</tt> - <tt>99</tt>
#   Default: <tt>99</tt>
#
#  [*stats_logfile*]
#   string:  enable logging of stastics to a file
#   values:  fully qualified path to the statis logfile (directory must exist and be writable) or 'Off'
#   Default: <tt>undef</tt>
#
#  [*stats_netlink_reliable*]
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#   Default: <tt>Off</tt>
#
#  [*stats_syslog*]
#   string:  enable syslog logging of statistics
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt> 
#
# === Authors
#
# * Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd::config ( 
  $protocol                   = $conntrackd::params::protocol,
  $nice                       = $conntrackd::params::nice,
  $hashsize                   = $conntrackd::params::hashsize,
  $hashlimit                  = $conntrackd::params::hashlimit,
  $logfile                    = $conntrackd::params::logfile,
  $syslog                     = $conntrackd::params::syslog,
  $lockfile                   = $conntrackd::params::lockfile,
  $sock_path                  = $conntrackd::params::sock_path,
  $sock_backlog               = $conntrackd::params::sock_backlog,
  $ignore_ips_ipv4            = $conntrackd::params::ignore_ips_ipv4,
  $ignore_ips_ipv6            = $conntrackd::params::ignore_ips_ipv6,
  $tcp_flows                  = $conntrackd::params::tcp_flows,
  $netlinkbuffersize          = $conntrackd::params::netlinkbuffersize,
  $netlinkbuffersizemaxgrowth = $conntrackd::params::netlinkbuffersizemaxgrowth,
  $netlinkoverrunresync       = $conntrackd::params::netlinkoverrunresync,
  $netlinkeventsreliable      = $conntrackd::params::netlinkeventsreliable,
  $pollsecs                   = $conntrackd::params::pollsecs,
  $eventiterationlimit        = $conntrackd::params::eventiterationlimit,
  $sync_mode                  = $conntrackd::params::sync_mode,
  $resend_queue_size          = $conntrackd::params::resend_queue_size,
  $ack_window_size            = $conntrackd::params::ack_window_size,
  $disable_external_cache     = $conntrackd::params::disable_external_cache,
  $disable_internal_cache     = $conntrackd::params::disable_internal_cache,
  $refresh_time               = $conntrackd::params::refresh_time,
  $cache_timeout              = $conntrackd::params::cache_timeout,
  $commit_timeout             = $conntrackd::params::commit_timeout,
  $purge_timeout              = $conntrackd::params::purge_timeout,
  $interface                  = $conntrackd::params::interface,
  $ipv4_address               = $conntrackd::params::ipv4_address,
  $ipv4_interface             = $conntrackd::params::ipv4_interface,
  $mcast_group                = $conntrackd::params::mcast_group,
  $sndsocketbuffer            = $conntrackd::params::sndsocketbuffer,
  $rcvsocketbuffer            = $conntrackd::params::rcvsocketbuffer,
  $checksum                   = $conntrackd::params::checksum,
  $udp_ipv6_address           = $conntrackd::params::udp_ipv6_address,
  $udp_ipv4_dest              = $conntrackd::params::udp_ipv4_dest,
  $udp_ipv6_dest              = $conntrackd::params::udp_ipv6_dest,
  $udp_port                   = $conntrackd::params::udp_port,
  $filter_accept_protocols    = $conntrackd::params::filter_accept_protocols,
  $tcp_window_tracking        = $conntrackd::params::tcp_window_tracking,
  $track_tcp_states           = $conntrackd::params::track_tcp_states,
  $scheduler_type             = $conntrackd::params::scheduler_type,
  $scheduler_priority         = $conntrackd::params::scheduler_priority,
  ) inherits conntrackd {

  #### Config management

  # set params: in operation
  if $conntrackd::ensure == 'present' {
      $config_exists     = 'present'
      $config_dir_exists = 'directory'

  # set params: removal
  } else {
      $config_exists     = 'absent'
      $config_dir_exists = 'absent'
  }

  # sanity check some paramaters
  if $interface == undef {
    fail("\"${module_name}\": interface must be specified")
  }
  
  case $sync_mode {
    'FTFW', 'NOTRACK', 'ALARM': {}
    default: {
      fail("\"${module_name}\": sync_mode \"${sync_mode}\" set incorrectly. Must be one of: 'FTFW', 'NOTRACK', 'ALARM'")
    }
  }

  case $protocol {
    'Multicast': {
      if ( $ipv4_address == undef or $ipv4_interface == undef or $mcast_group == undef or $interface == undef ) {
        fail("\"${module_name}\": protocol \"${protocol}\" requires params: ipv4_address, ipv4_interface, mcast_group and interface to be specified")
      }
    }
    'UDP': {
      if ( ($ipv4_address == undef) and ($ipv6_address == undef) ) {
        fail("\"${module_name}\": protocol \"${protocol}\" requires atleast one of: ipv4_address, ipv6_address to be specified")
      }
      if ( $ipv4_address and ($udp_ipv4_dest == undef) ) {
        fail("\"${module_name}\": protocol \"${protocol}\" udp_ipv4_dest must be specified if ipv4_address is specified")
      }
      if ( $ipv6_address and ($udp_ipv6_dest == undef) ) {
        fail("\"${module_name}\": protocol \"${protocol}\" udp_ipv6_dest must be specified if ipv6_address is specified")
      }
    }
    default: {
        fail("\"${module_name}\": protocol \"${protocol}\" set incorrectly. Must be one of: 'Multicast', 'UDP'")
    }
  }

  # manage config dir
  file { 'conntrackd-confdir':
    path    => $conntrackd::params::config_dir,
    ensure  => $config_dir_exists,
    mode    => '0755',
  }

  # configuration file
  file { 'conntrackd-config':
    ensure  => $config_exists,
    path    => "${conntrackd::params::config_dir}/${conntrackd::params::config_filename}",
    content => template('conntrackd/conntrackd.conf.erb'),
    mode    => '0644',
    require => File['conntrackd-confdir'],
    notify  => Service['conntrackd'],
  }
}

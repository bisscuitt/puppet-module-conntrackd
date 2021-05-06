# # conntrackd::config
#
# @summary This class exists to coordinate all configuration for the conntrackd daemon
#
# @param ensure
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>.
#   Default: <tt>present</tt>.
#
# @param nice
#   integer: Nice value of the conntrackd process
#   range: <tt>-19</tt> to <tt>+19</tt>
#   Default: <tt>-1</tt>
#
# @param hashsize
#   integer: Number of buckets in the cache hashtable.
#   Default: <tt>32768</tt>
#
# @param hashlimit
#   integer: Maximum number of conntracks in table
#   Default: <tt>2x the value of /proc/sys/net/netfilter/nf_conntrack_max</tt>
#
# @param logfile
#   string:  fully qualified path to the logfile or 'Off'
#            (directory must exist and be writable)
#   values:  <tt>on</tt>, <tt>off</tt>, <tt><path to file></tt>
#   Default: <tt>off</tt>
#
# @param syslog
#   string:  enable syslog logging
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt>
#   Default: <tt>on</tt>
#
# @param lockfile
#   string:  fully qualified path to the lockfile
#   Default: <tt>/var/lock/conntrack.lock</tt>
#
# @param sock_path
#   string:  fully qualified path to the UNIX socket used for configuration
#   Default: <tt>/var/run/conntrackd.ctl</tt>
#
# @param sock_backlog
#   integer: sets the blacklog ofr the UNIX socket
#   Default: <tt>20</tt>
#
# @param ignore_ips_ipv4
#   array:   list of IPv4 addresses to ignore.
#            should include this node's address
#   Default: <tt>[ '127.0.0.1', '192.168.0.1', '10.1.1.1' ]</tt>
#
# @param ignore_ips_ipv6
#   array:   list of IPv4 addresses to ignore.
#            should include this node's address
#   Default: <tt>[ '::1' ]</tt>
#
# @param tcp_flows
#   array:   list of flows to monitor
#   allowed: 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT'
#   Default: <tt>[ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]</tt>
#
# @param netlinkbuffersize
#   integer: Netlink event socket buffer size
#   Default: <tt>2097152</tt>
#
# @param netlinkbuffersizemaxgrowth
#   integer: The daemon doubles the size of the netlink event socket buffer size
#            if it detects netlink event message dropping . This clause sets the
#            maximum buffer size growth that can be reached.
#   Default: <tt>8388608</tt>
#
# @param netlinkoverrunresync
#   boolean: If the daemon detects that Netlink is dropping state-change events,
#            it automatically schedules a resynchronization against the Kernel
#            after 30 seconds (default value)
#   Default: <tt>on</tt>
#
# @param netlinkeventsreliable
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#   Default: <tt>Off</tt>
#
# @param pollsecs
#   integer: By default, the daemon receives state updates following an
#            event-driven model. You can modify this behaviour by switching to
#            polling mode with the PollSecs clause.
#   Default: <tt>Off</tt>
#
# @param eventiterationlimit
#   integer: The daemon prioritizes the handling of state-change events coming
#            from the core. With this clause, you can set the maximum number of
#            state-change events (coming from kernel-space) that the daemon
#            will handle after which it will handle other events coming from the
#            network or userspace
#   Default: <tt>100</tt>
#
# @param sync_mode
#   string:  The syncronisation mode to use
#   values:  one of: <tt>FTFW</tt>, <tt>NOTRACK</tt> or <tt>ALARM</tt>
#   Default: <tt>FTFW</tt>
#
# @param resend_queue_size
#   integer: Size of the resend queue (in objects)
#   Default: <tt>131072</tt>
#
# @param ack_window_size
#   integer: acknowledgement window size. If you decrease this
#            value, the number of acknowlegdments increases
#   Default: <tt>300</tt>
#
# @param disable_external_cache
#   boolean: This clause allows you to disable the external cache. Thus,
#            the state entries are directly injected into the kernel
#            conntrack table.
#   Default: <tt>Off</tt>
#
# @param disable_internal_cache
#   boolean: This clause allows you to disable the internal cache.
#   Default: <tt>Off</tt>
#
# @param refresh_time
#   integer: ALARM Mode: If a conntrack entry is not modified in <= 15 seconds,
#            then a message is broadcasted.
#   Default: <tt>15</tt>
#
# @param cache_timeout
#   integer: If we don't receive a notification about the state of
#            an entry in the external cache after N seconds, then
#            remove it.
#   Default: <tt>180</tt>
#
# @param commit_timeout
#   integer: This parameter allows you to set an initial fixed timeout
#            for the committed entries when this node goes from backup
#            to primary.
#   Default: <tt>180</tt>
#
# @param purge_timeout
#   integer: If the firewall replica goes from primary to backup,
#            the conntrackd -t command is invoked in the script.
#            This command schedules a flush of the table in N seconds.
#   Default: <tt>60</tt>
#
# @param protocol
#   string:  The protocol to use for syncing.
#   values:  <tt>Multicast</tt> or <tt>UDP</tt>
#   Default: <tt>Multicast</tt>
#
# @param interface
#   string:  Dedicated physical interface for communicating with the other host.
#   value:   <tt><interface name></tt>
#   Default: <tt>undef</tt>
#
# @param ipv4_address
#   string:  Multicast mode only: The multicast address to commuincate over
#   value:   *Must* be set for Multicast mode: <tt><multicast address></tt>
#   Default: <tt>255.0.0.50</tt>
#
# @param ipv4_interface
#   string:  The ip address to bind to for multicast and UDP connections.
#   value:   *Must* be set for Multicast or UDP mode: <tt><ipaddress></tt>
#   Default: <tt>undef</tt>
#
# @param mcast_group
#   integer: The multicast group to use for Multicast mode
#   Default: <tt>3780</tt>
#
# @param sndsocketbuffer
#   integer: The multicast sender uses a buffer to enqueue the packets
#            that are going to be transmitted.
#   Default: <tt>1249280</tt>
#
# @param rcvsocketbuffer
#   integer: The multicast receiver uses a buffer to enqueue the packets
#            that the socket is pending to handle.
#   Default: <tt>1249280</tt>
#
# @param checksum
#   integer: Enable/Disable message checksumming.
#   Default: <tt>on</tt>
#
# @param udp_ipv6_address
#   string:  The IPv6 interface address to bind to in UDP mode
#   Default: <tt>undef</tt>
#
# @param udp_ipv4_dest
#   string:  The IPv4 interface of the other node when UDP is enabled
#   Default: <tt>undef</tt>
#
# @param udp_ipv6_dest
#   string:  The IPv6 interface of the other node when UDP is enabled
#   Default: <tt>undef</tt>
#
# @param udp_port
#   integer: The UDP port to communicate over (should be the same on both nodes)
#   Default: <tt>3780</tt>
#
# @param filter_accept_protocols
#   array:   Accept only certain protocols
#   values:  <tt>TCP</tt>, <tt>SCTP</tt>, <tt>DCCP</tt>,
#            <tt>UDP</tt>, <tt>ICMP</tt>, <tt>IPv6-ICMP</tt>
#   Default: <tt>[ 'TCP', 'SCTP', 'DCCP' ]</tt>
#
# @param tcp_window_tracking
#   boolean: TCP state-entries have window tracking disabled by default,
#            you can enable it with this option.
#   Default: <tt>Off</tt>
#
# @param track_tcp_states
#   array:   The specific TCP states to sync
#   Default: <tt>[ 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT' ]</tt>
#
# @param scheduler_type
#   string:  Select a different scheduler for the daemon.
#            See man sched_setscheduler(2) for more information. Using a RT
#            scheduler reduces the chances to overrun the Netlink buffer.
#   values:  <tt>RR</tt>, <tt>FIFO</tt>
#   Default: <tt>FIFO</tt>
#
# @param scheduler_priority
#   integer: scheduler process priority
#   range:   <tt>0</tt> - <tt>99</tt>
#   Default: <tt>99</tt>
#
# @param stats_logfile
#   string:  enable logging of stastics to a file
#   values:  fully qualified path to the statis logfile or 'Off'
#   Default: <tt>undef</tt>
#
# @param stats_netlink_reliable
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#   Default: <tt>Off</tt>
#
# @param stats_syslog
#   string:  enable syslog logging of statistics
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt>
#
# @author Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd::config (
  Enum['present', 'absent']        $ensure                     = $conntrackd::ensure,
  Enum['Multicast', 'UDP']         $protocol                   = $conntrackd::protocol,
  Integer[-20,19]                  $nice                       = $conntrackd::nice,
  Integer                          $hashsize                   = $conntrackd::hashsize,
  Integer                          $hashlimit                  = $conntrackd::_hashlimit,
  String                           $logfile                    = $conntrackd::logfile,
  String                           $syslog                     = $conntrackd::syslog,
  String                           $lockfile                   = $conntrackd::lockfile,
  String                           $sock_path                  = $conntrackd::sock_path,
  Integer                          $sock_backlog               = $conntrackd::sock_backlog,
  Array                            $ignore_ips_ipv4            = $conntrackd::ignore_ips_ipv4,
  Array                            $ignore_ips_ipv6            = $conntrackd::ignore_ips_ipv6,
  Array                            $tcp_flows                  = $conntrackd::tcp_flows,
  Integer                          $netlinkbuffersize          = $conntrackd::netlinkbuffersize,
  Integer                          $netlinkbuffersizemaxgrowth = $conntrackd::netlinkbuffersizemaxgrowth,
  String                           $netlinkoverrunresync       = $conntrackd::netlinkoverrunresync,
  String                           $netlinkeventsreliable      = $conntrackd::netlinkeventsreliable,
  Optional[Integer]                $pollsecs                   = $conntrackd::pollsecs,
  Integer                          $eventiterationlimit        = $conntrackd::eventiterationlimit,
  Enum['FTFW', 'NOTRACK', 'ALARM'] $sync_mode                  = $conntrackd::sync_mode,
  Integer                          $resend_queue_size          = $conntrackd::resend_queue_size,
  Integer                          $ack_window_size            = $conntrackd::ack_window_size,
  String                           $disable_external_cache     = $conntrackd::disable_external_cache,
  String                           $disable_internal_cache     = $conntrackd::disable_internal_cache,
  Integer                          $refresh_time               = $conntrackd::refresh_time,
  Integer                          $cache_timeout              = $conntrackd::cache_timeout,
  Integer                          $commit_timeout             = $conntrackd::commit_timeout,
  Integer                          $purge_timeout              = $conntrackd::purge_timeout,
  String                           $interface                  = $conntrackd::interface,
  String                           $ipv4_address               = $conntrackd::ipv4_address,
  String                           $ipv4_interface             = $conntrackd::ipv4_interface,
  String                           $mcast_group                = $conntrackd::mcast_group,
  Integer                          $sndsocketbuffer            = $conntrackd::sndsocketbuffer,
  Integer                          $rcvsocketbuffer            = $conntrackd::rcvsocketbuffer,
  String                           $checksum                   = $conntrackd::checksum,
  Optional[String]                 $udp_ipv6_address           = $conntrackd::udp_ipv6_address,
  Optional[String]                 $udp_ipv4_dest              = $conntrackd::udp_ipv4_dest,
  Optional[String]                 $udp_ipv6_dest              = $conntrackd::udp_ipv6_dest,
  Integer                          $udp_port                   = $conntrackd::udp_port,
  Array                            $filter_accept_protocols    = $conntrackd::filter_accept_protocols,
  String                           $tcp_window_tracking        = $conntrackd::tcp_window_tracking,
  Array                            $track_tcp_states           = $conntrackd::track_tcp_states,
  String                           $scheduler_type             = $conntrackd::scheduler_type,
  String                           $scheduler_priority         = $conntrackd::scheduler_priority,
  Optional[String]                 $stats_logfile              = $conntrackd::stats_logfile,
  String                           $stats_netlink_reliable     = $conntrackd::stats_netlink_reliable,
  Optional[String]                 $stats_syslog               = $conntrackd::stats_syslog,

) {
  assert_private()

  #### Config management

  # set params: in operation
  if $ensure == 'present' {
      $config_exists     = 'present'
      $config_dir_exists = 'directory'

  # set params: removal
  } else {
      $config_exists     = 'absent'
      $config_dir_exists = 'absent'
  }

  # sanity check some paramaters
  if $protocol == 'UDP' {
    if $ipv4_address == undef and $udp_ipv6_address == undef {
      fail("\"${module_name}\": protocol \"${protocol}\" requires atleast one of: ipv4_address, ipv6_address to be specified")
    }
    if $ipv4_address and $udp_ipv4_dest == undef {
      fail("\"${module_name}\": protocol \"${protocol}\" udp_ipv4_dest must be specified if ipv4_address is specified")
    }
    if $udp_ipv6_address and $udp_ipv6_dest == undef {
      fail("\"${module_name}\": protocol \"${protocol}\" udp_ipv6_dest must be specified if ipv6_address is specified")
    }
  }

  # manage config dir
  file { 'conntrackd-confdir':
    ensure => $config_dir_exists,
    path   => $conntrackd::config_dir,
    mode   => '0755',
  }

  # configuration file
  file { 'conntrackd-config':
    ensure  => $config_exists,
    path    => "${conntrackd::config_dir}/${conntrackd::config_filename}",
    content => epp('conntrackd/conntrackd.conf.epp'),
    mode    => '0644',
    require => File['conntrackd-confdir'],
    notify  => Service['conntrackd'],
  }
}

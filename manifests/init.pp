# # conntrackd
#
# @summary This class is able to install or remove conntrackd on a node. It
# manages the status and configuration of the service.
#
# @param ensure
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * The managed software packages are being uninstalled.
#   * Any traces of the packages will be purged as good as possible. This may
#     include existing configuration files. The exact behavior is provider
#     dependent. Q.v.:
#     * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#     * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#   Defaults to <tt>present</tt>.
#
# @param autoupgrade
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Q.v.:
#   * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
#   * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   Defaults to <tt>false</tt>.
#
# @param status
#   String to define the status of the service. Possible values:
#   * <tt>enabled</tt>: Service is running and will be started at boot time.
#   * <tt>disabled</tt>: Service is stopped and will not be started at boot
#     time.
#   * <tt>running</tt>: Service is running but will not be started at boot time.
#     You can use this to start a service on the first Puppet run instead of
#     the system startup.
#   * <tt>unmanaged</tt>: Service will not be started at boot time and Puppet
#     does not care whether the service is running or not. For example, this may
#     be useful if a cluster management software is used to decide when to start
#     the service plus assuring it is running on the desired node.
#   Defaults to <tt>enabled</tt>. The singular form ("service") is used for the
#   sake of convenience. Of course, the defined status affects all services if
#   more than one is managed (see <tt>service.pp</tt> to check if this is the
#   case).
#
# @param package The name(s) of the conntrack package(s)
# @param service_name The name of the conntrackd service
# @param service_hasrestart The service `hasrestart` attribute
# @param service_hasstatus The service `hasstatus` attribute
# @param service_pattern The service `pattern` attribute
# @param service_status The service `status` attribute
# @param config_dir Top-level directory for configuration
# @param config_filename Config file name
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
# @param hashlimit
#   integer: Maximum number of conntracks in table
#   Default: <tt>2x the value of /proc/sys/net/netfilter/nf_conntrack_max</tt>
#
# @example Installation, make sure service is running and will be started at boot time:
#     class { 'conntrackd': }
#
# @example Removal/decommissioning:
#     class { 'conntrackd':
#       ensure => 'absent',
#     }
#
# @example Install everything but disable service(s) afterwards
#     class { 'conntrackd':
#       status => 'disabled',
#     }
#
# @author Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd (
  Enum['present', 'absent']        $ensure,
  Boolean                          $autoupgrade,
  Enum[
    'enabled',
    'disabled',
    'running',
    'unmanaged'
  ]                                $status,
  Array                            $package,
  String                           $service_name,
  Boolean                          $service_hasrestart,
  Boolean                          $service_hasstatus,
  String                           $service_pattern,
  String                           $service_status,
  String                           $config_dir,
  String                           $config_filename,
  Integer[-20,19]                  $nice,
  Integer                          $hashsize,
  String                           $logfile,
  String                           $syslog,
  String                           $lockfile,
  String                           $sock_path,
  Integer                          $sock_backlog,
  Array                            $ignore_ips_ipv4,
  Array                            $ignore_ips_ipv6,
  Array                            $tcp_flows,

  Integer                          $netlinkbuffersize,
  Integer                          $netlinkbuffersizemaxgrowth,
  String                           $netlinkoverrunresync,
  String                           $netlinkeventsreliable,
  Optional[Integer]                $pollsecs,
  Integer                          $eventiterationlimit,

  Enum['FTFW', 'NOTRACK', 'ALARM'] $sync_mode,
  Integer                          $resend_queue_size,
  Integer                          $ack_window_size,
  String                           $disable_external_cache,
  String                           $disable_internal_cache,
  Integer                          $refresh_time,
  Integer                          $cache_timeout,
  Integer                          $commit_timeout,
  Integer                          $purge_timeout,

  Enum['Multicast', 'UDP']         $protocol,
  String                           $interface,
  String                           $ipv4_address,
  String                           $ipv4_interface,
  String                           $mcast_group,
  Integer                          $sndsocketbuffer,
  Integer                          $rcvsocketbuffer,
  String                           $checksum,
  Optional[String]                 $udp_ipv6_address,
  Optional[String]                 $udp_ipv4_dest,
  Optional[String]                 $udp_ipv6_dest,
  Integer                          $udp_port,

  Array                            $filter_accept_protocols,

  String                           $tcp_window_tracking,
  Array                            $track_tcp_states,

  String                           $scheduler_type,
  String                           $scheduler_priority,

  Optional[String]                 $stats_logfile,
  String                           $stats_netlink_reliable,
  Optional[String]                 $stats_syslog,

  # -- Set the hashlimit to be double the sysctl valueof net.nf_conntrack_max
  #    uses custom fact defined in this module
  Optional[Integer]                $hashlimit                  = undef,
) {
  #### Validate parameters
  if $hashlimit {
    $_hashlimit = $hashlimit
  } elsif $facts['nf_conntrack_max'] {
    $_hashlimit = ($facts['nf_conntrack_max'] + 0) * 2
  } else {
    $_hashlimit = 131072
  }

  #### Manage actions

  # package
  include conntrackd::package

  # service
  include conntrackd::service

  #### Manage relationships

  if $ensure == 'present' {
    include conntrackd::config

    # we need the software before running a service
    Class['conntrackd::package'] -> Class['conntrackd::config'] ~> Class['conntrackd::service']

  } else {

    # make sure all services are getting stopped before software removal
    Class['conntrackd::service'] -> Class['conntrackd::package']
  }

}

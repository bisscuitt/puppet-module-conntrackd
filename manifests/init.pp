# == Class: conntrackd
#
# This class is able to install or remove conntrackd on a node. It manages the
# status and configuration of the service.
#
# === Parameters
#
# [*ensure*]
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
# [*autoupgrade*]
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Q.v.:
#   * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
#   * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   Defaults to <tt>false</tt>.
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
#     does not care whether the service is running or not. For example, this may
#     be useful if a cluster management software is used to decide when to start
#     the service plus assuring it is running on the desired node.
#   Defaults to <tt>enabled</tt>. The singular form ("service") is used for the
#   sake of convenience. Of course, the defined status affects all services if
#   more than one is managed (see <tt>service.pp</tt> to check if this is the
#   case).
#
# The default values for the parameters are set in conntrackd::params. Have
# a look at the corresponding <tt>params.pp</tt> manifest file if you need more
# technical information about them.
#
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#     class { 'conntrackd': }
#
# * Removal/decommissioning:
#     class { 'conntrackd':
#       ensure => 'absent',
#     }
#
# * Install everything but disable service(s) afterwards
#     class { 'conntrackd':
#       status => 'disabled',
#     }
#
#
# === Authors
#
# * Ian Bissett <mailto:bisscuitt@gmail.com>
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

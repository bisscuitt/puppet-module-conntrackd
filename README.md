# puppet-module-conntrackd

Puppet module to manage conntrackd.

Have a look at the main module class (<tt>init.pp</tt>) to see what this
module does on a node plus usage examples.


## Compatibility

Supports both ipv4 and ipv6, all conntrackd options and all sync modes.

Compatible with Debian, Ubuntu and RedHat, Fedora, Centos, Scientific distros.

This module is designed to work with Puppet version 2.7.x or newer.

## Requirements

This module has got the following module dependencies:

[stdlib]
  Version 2.3.1 or newer. Standard library of useful resources by Puppet Labs.
  It provides functions like validate\_\*(), is\_\*() and empty(). 
  More information:
  * stdlib at Puppet Forge <http://forge.puppetlabs.com/puppetlabs/stdlib>
  * The module source code <http://j.mp/w00GZr> to get a listing of available
    functions.

## Usage examples

### Install and manage the conntrackd service

```
  class  { "conntrackd": }
```

### Multicast Sync over eth1 using the default FTFW sync mode:

```
  class { "conntrackd::config":
          protocol       => 'Multicast',
          interface      => 'eth1',
          ipv4_address   => ${multicast_address},
          ipv4_interface => ${ipaddress_eth1},
  }
```

### UDP Sync over eth2 using the ALARM sync mode:

```
  class  { "conntrackd::config":
          sync_mode      => 'ALARM',
          protocol       => 'UDP',
          interface      => 'eth2',
          ipv4_address   => ${ipaddress_eth2},
          udp_ipv4_dest  => ${other_remote_host},
  }
```

### Remove service, package and configuration of conntrackd:

````
  class  { "conntrackd":
          ensure         => 'absent'
  }
```

You can find more examples in the examples dir.

## Links

* Official conntrackd website <http://conntrack-tools.netfilter.org/conntrackd.html>
* Official project page <https://github.com/bisscuitt/puppet-module-conntrackd>
* Official Puppet Style Guide <http://j.mp/fCVSng>

## License, Copyright

See COPYING and NOTICE file in the root directory of this module.


# A simple Multicast configuration over eth1

class { 'conntrackd::config':
  protocol       => 'Multicast',
  sync_mode      => 'FTFW',
  interface      => 'eth1',
  ipv4_address   => '224.0.0.1',
  ipv4_interface => '192.168.122.162',
}


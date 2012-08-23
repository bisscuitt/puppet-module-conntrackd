# UDP Syncing with conntrackd

class  { "conntrackd::config":
	protocol       => 'UDP',
	interface      => 'eth0',
	ipv4_address   => '192.168.122.162',
	udp_ipv4_dest  => '192.168.122.161',
}

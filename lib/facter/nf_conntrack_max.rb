# get the value of /proc/sys/net/netfilter/nf_conntrack_max
Facter.add("nf_conntrack_max") do
  confine :kernel => :linux
  setcode do
    Facter::Util::Resolution.exec('/bin/cat /proc/sys/net/netfilter/nf_conntrack_max').chomp
  end
end

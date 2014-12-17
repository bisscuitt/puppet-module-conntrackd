# get the value of /proc/sys/net/netfilter/nf_conntrack_max
f = [ '/proc/sys/net/netfilter/nf_conntrack_max',
      '/proc/sys/net/ipv4/ip_conntrack_max' ].find{|f| File.exists?(f) }
if f
  Facter.add("nf_conntrack_max") do
    confine :kernel => :linux
    setcode do
      File.read(f).chomp
    end
  end
end

# get the value of /proc/sys/net/netfilter/nf_conntrack_max
f = ['/proc/sys/net/netfilter/nf_conntrack_max',
     '/proc/sys/net/ipv4/ip_conntrack_max'].find { |file| File.exist?(file) }
if f
  Facter.add('nf_conntrack_max') do
    confine kernel: :linux
    setcode do
      File.read(f).chomp
    end
  end
end

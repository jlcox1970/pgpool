class pgpool::firewall (
    $port = $port
  ){
    @firewall { 'pgpool listen port':
    dport   => $port,
    proto   => tcp,
    action  => accept,
    tag  => 'pgpool_firewall'
  }
}
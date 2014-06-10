class pgpool::reattach (
  $pcp_port = $pgpool::pcp_port,
  $pcp_user = $pgpool::pcp_user,
  $pcp_password = $pgpool::pcp_password,
  $backend = $pgpool::backend
){
  Exec {
    path => '/bin:/usr/bin:/usr/sbin'
  }
  exec { "pcp_attach_node 1 localhost ${pcp_port} ${pcp_user} ${pcp_password} ${backend}" :
    onlyif => "pcp_pool_status  1 localhost ${pcp_port} ${pcp_user} ${pcp_password} |sed '/backend_status${backend}/,/desc/ !d' |grep value |cut -d' ' -f2"
  }
}

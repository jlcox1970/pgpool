class pgpool::pcp_conf (
  $pcp_user = $pgpool::pcp_user,
  $hash_password = $pgpool::hash_password
){
  
  file_line { "pcp_conf : ${pcp_user}" :
    ensure => true,
    path   => 'pcp.conf',
    line   => "${pcp_user}:${hash_password}",
    match  => "^${pcp_user}:*"
  }
}
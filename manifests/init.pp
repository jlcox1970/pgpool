# Class: pgpool
#
# This module manages pgpool
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class pgpool (
    $pgpool_port = 5432,
    $with_haproxy = false,
    $manage_firewall = false,
    $pcp_port = 9989,
    $pcp_user ='',
    $pcp_password = '',
    $backend = ''
 ){
  $hash_password = postgresql_password ( "${pcp_user}", "${pcp_password}" )
  
  include epel

  if ( $manage_firewall == true) {
    class { pgpool::firewall :
      port => $pgpool_port,
    }
  }
  package { "pgpool-II-93":
    ensure  => latest
  } ->
  service { "pgpool-II-93":
    ensure  => running,
    enable  => true
  } ->

  file { "/etc/pgpool-II-93/pgpool.conf":
    mode    => 644,
    source  => "puppet:///modules/${module_name}/pgpool.conf",
    notify  => Service["pgpool-II-93"],
  } ->
  class { pgpool::pcp_conf : } ->
  class { pgpool::reattach : } ->
  file { "/var/run/pgpool":
    ensure  => "directory",
    mode    => 644,
    owner   => postgres,
    group   => postgres,
  }
  file { "/var/log/pgpool-II":
    ensure  => "directory",
    mode    => 644,
    owner   => postgres,
    group   => postgres,
  }
  Firewall <| tag == 'pgpool_firewall' |>
  Notify <<| tag == "pgpool-II-93-service" |>>
}


}

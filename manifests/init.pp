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
    
  ){
    
  include epel

  if ( $manage_firewall == true) {
    class {pgpool::firewall :
      port => $pgpool_port,
    }
  }
  package { "pgpool-II-93":
    ensure  => latest
  } ->
  service { "pgpool-II-93":
    ensure  => running,
    enable  => true
  }

  file { "/etc/pgpool-II-93/pgpool.conf":
    mode    => 644,
    source  => "puppet:///modules/${module_name}/pgpool.conf",
    notify  => Service["pgpool-II-93"],
  }
  file { "/etc/pgpool-II-93/pcp.conf":
    mode    => 644,
    source  => "puppet:///modules/${module_name}/pcp.conf",
    notify  => Service["pgpool-II-93"],
  }
  file { "/usr/local/bin/reattach.sh":
    mode    => 700,
    source  => "puppet:///modules/${module_name}/reattach.sh",
  }
  exec { "/usr/local/bin/reattach.sh":
    path    => "/bin:/usr/bin:/usr/local/bin",
  }
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

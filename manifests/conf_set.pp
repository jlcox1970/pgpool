class pgpool::conf_set (
  $option      = '',
  $value       = '',
  $separator   = '=',
  $config_file = ''
){
  file_line { "$config_file : Setting option $option to $value" :
    path => $config_file,
    line => "${option}${separator}${value}",
    match  => "^${option}*"
  }
}

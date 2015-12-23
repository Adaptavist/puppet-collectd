define collectd::plugin::jmx::connection(
  $service_url = undef,
  $user        = undef,
  $password    = undef,
  $host        = undef,
  $port        = undef,
  $collect     = [ 'classes', 'compilation',
                  'garbage_collector', 'memory',
                  'memory_pool' ]
) {

  if $service_url == undef {
    $used_service_url = "service:jmx:rmi:///jndi/rmi://${host}:${port}/jmxrmi"
  } else {
    $used_service_url = $service_url
  }

  collectd::plugin::jmx::register { $name:
    content => template("${module_name}/plugin_jmx_connection.conf.erb"),
    order   => 30,
  }
}
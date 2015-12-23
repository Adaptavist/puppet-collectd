class collectd::client(
  $server_host = $collectd::server_host,
  $server_port = $collectd::server_port,
) {
  include collectd

  collectd::plugin { 'client':
    type  => 'network',
    lines => [ "Server \"${server_host}\" \"${server_port}\"" ]
  }
}
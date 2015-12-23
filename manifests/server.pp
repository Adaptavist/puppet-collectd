class collectd::server(
  $listen_host       = '0.0.0.0',
  $listen_port       = '25826',
  $write_graphite    = 'true',
  $graphite_host     = '127.0.0.1',
  $graphite_port     = '2003',
  $graphite_protocol = 'tcp',
  $graphite_prefix   = 'collectd.',
  $graphite_postfix  = '',
) {
  include collectd

  if str2bool($::selinux) {
    selboolean { 'collectd_tcp_network_connect':
      persistent => true,
      value      => 'on',
    }
  }

  collectd::plugin { 'server_network_listen':
    type  => network,
    lines => [
      "Listen \"${listen_host}\" \"${listen_port}\"",
    ],
  }

  collectd::plugin { 'server_graphite_write':
    onlyif => $write_graphite,
    type   => 'write_graphite',
    lines  => [
      '<Carbon>',
      "  Host \"${graphite_host}\"",
      "  Port \"${graphite_port}\"",
      "  Protocol \"${graphite_protocol}\"",
      "  Prefix \"${graphite_prefix}\"",
      "  Postfix \"${graphite_postfix}\"",
      '</Carbon>'
    ],
  }

}

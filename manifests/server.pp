class collectd::server(
  $listen_host                  = '0.0.0.0',
  $listen_port                  = '25826',
  $write_graphite               = 'true',
  $graphite_host                = '127.0.0.1',
  $graphite_port                = '2003',
  $graphite_protocol            = 'tcp',
  $graphite_prefix              = 'collectd.',
  $graphite_postfix             = '',
  $collectd_auth_file           = 'false',
  $collectd_auth_file_content   = '',
  $collectd_auth_security_level = 'Encrypt',
) {
  include collectd

  if str2bool($::selinux) {
    selboolean { 'collectd_tcp_network_connect':
      persistent => true,
      value      => 'on',
    }
  }

  if ($collectd_auth_file != 'false' and $collectd_auth_file != false) {
    $real_lines = [
      "<Listen \"${listen_host}\" \"${listen_port}\">",
        "SecurityLevel \"${collectd_auth_security_level}\"",
        "AuthFile \"${collectd_auth_file}\"",
      '</Listen>' ]

    file {$collectd_auth_file:
      ensure  => file,
      content => $collectd_auth_file_content,
      owner   => 'root',
      group   => 'root',
      mode    => '0644';
    }
    $listen_require = "File[${collectd_auth_file}]"
  } else {
    $real_lines = ["Listen \"${listen_host}\" \"${listen_port}\""]
    $listen_require = 'Class[Collectd]'
  }

  collectd::plugin { 'server_network_listen':
    type    => 'network',
    lines   => $real_lines,
    require => $listen_require,
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

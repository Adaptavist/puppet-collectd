class collectd::client(
  $server_host                  = $collectd::server_host,
  $server_port                  = $collectd::server_port,
  $collectd_auth_username       = 'false',
  $collectd_auth_password       = 'false',
  $collectd_auth_security_level = 'Encrypt',
  $write_logstash               = 'true',
  $logstash_server_host         = '0.0.0.0',
  $logstash_server_port         = '25825',
) {
  include collectd

  if ($collectd_auth_username != 'false' and $collectd_auth_username != false) {
    $client_lines = [
      "<Server \"${server_host}\" \"${server_port}\">",
        "SecurityLevel \"${collectd_auth_security_level}\"",
        "Username \"${collectd_auth_username}\"",
        "Password \"${collectd_auth_password}\"",
      '</Server>' ]
    $logstash_lines = [
      "<Server \"${logstash_server_host}\" \"${logstash_server_port}\">",
        "SecurityLevel \"${collectd_auth_security_level}\"",
        "Username \"${collectd_auth_username}\"",
        "Password \"${collectd_auth_password}\"",
      '</Server>' ]
  } else {
    $client_lines = ["Server \"${server_host}\" \"${server_port}\""]
    $logstash_lines = ["Server \"${logstash_server_host}\" \"${logstash_server_port}\""]
  }

  collectd::plugin { 'client':
    type  => 'network',
    lines => $client_lines,
  }

  collectd::plugin { 'write_logstash_client':
    type   => 'network',
    onlyif => $write_logstash,
    lines  => $logstash_lines,
  }
}
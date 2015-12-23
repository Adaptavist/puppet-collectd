class collectd::plugin::tcpconns($localports = [],
                                $remoteports = [],
                                $listeningports = true,
) {
  validate_array($localports)
  validate_array($remoteports)

  $ports = concat(
    prefix($localports, 'LocalPort '),
    prefix($remoteports, 'RemotePort '))

  $lines = concat(
    ["ListeningPorts ${listeningports}"],
    $ports)

  collectd::plugin { 'tcpconns':
    type  => 'tcpconns',
    lines => $lines,
  }
}
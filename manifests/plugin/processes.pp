class collectd::plugin::processes(
    $processes = [],
    ) {
  validate_array($processes)
  collectd::plugin { 'processes':
    type  => 'processes',
    lines => prefix($processes, 'Process '),
  }
}

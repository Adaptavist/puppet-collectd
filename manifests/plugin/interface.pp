class collectd::plugin::interface {
  collectd::plugin { 'interface':
    type  => 'interface',
    lines => [
      'Interface "lo"',
      'IgnoreSelected true'
    ]
  }
}

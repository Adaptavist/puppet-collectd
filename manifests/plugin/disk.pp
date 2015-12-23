class collectd::plugin::disk {
  collectd::plugin { 'disk':
    type  => 'disk',
    lines => [
      'Disk "/(h|s|xv)da[1234]/"',
      'IgnoreSelected false'
    ]
  }
}

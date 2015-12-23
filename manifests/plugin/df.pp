class collectd::plugin::df {
  collectd::plugin { 'df':
    type  => 'df',
    lines => [
      'ReportInodes true',
      '# ignore rootfs; else, the root file-system would appear twice,',
      '# causing one of the updates to fail and spam the log',
      'FSType rootfs',
      '# ignore the usual virtual / temporary file-systems',
      'FSType sysfs',
      'FSType proc',
      'FSType devtmpfs',
      'FSType devpts',
      'FSType tmpfs',
      'FSType fusectl',
      'FSType cgroup',
      'IgnoreSelected true'
    ]
  }
}

class collectd::plugin::jmx(
  $mbeans          = {},
  $connections     = {},
  $default_mbeans  = true,
  $mbean_root      = "${collectd::plugins_root}/jmx-mbeans",
  $connection_root = "${collectd::plugins_root}/jmx-connections",
  $conf_file       = "${collectd::plugins_root}/jmx.conf",
) {

  concat { $conf_file:
    mode   => '0644',
    owner  => $collectd::owner,
    group  => $collectd::group,
    notify => Service['collectd'],
  }

  concat::fragment { 'jmx_header':
    target  => $conf_file,
    content => "LoadPlugin \"java\"\n<Plugin \"java\">\n  LoadPlugin \"org.collectd.java.GenericJMX\"\n",
    order   => 1,
  }
  concat::fragment { 'jmx_footer':
    target  => $conf_file,
    content => '</Plugin>',
    order   => '99',
  }

  create_resources('collectd::plugin::jmx::mbean', $mbeans)
  create_resources('collectd::plugin::jmx::connection', $connections)
}

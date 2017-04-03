class collectd::configuration(
    $collectd_conf_file = $collectd::conf_file,
    $collectd_ensure = $collectd::ensure,
    $collectd_owner = $collectd::owner,
    $collectd_group = $collectd::group,
    $collectd_plugins_root = $collectd::plugins_root,
    $collectd_install_dir = $collectd::install_dir,
    $collectd_included_conf = $collectd::included_conf,
  ) {

  file {['/usr/var', '/usr/var/lib', '/usr/var/lib/collectd']:
              ensure => directory,
              owner  => $collectd::user,
              group  => $collectd::group,
  } -> file { $collectd_conf_file:
    ensure  => $collectd_ensure,
    mode    => '0644',
    owner   => $collectd_owner,
    group   => $collectd_group,
    content => template("${module_name}/collectd.conf.erb"),
  }

  $plugin_root_ensure = $collectd_ensure ? {
    present => directory,
    absent  => absent,
    default => fail("Can't decide about \$collectd::ensure"),
  }

  file { $collectd_plugins_root:
    ensure => $plugin_root_ensure,
    mode   => '0755',
    owner  => $collectd_owner,
    group  => $collectd_group,
  }
}

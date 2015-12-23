define collectd::plugin(
  $type = '',
  $lines = [],
  $interval = undef,
  $onlyif = true,
  $collectd_plugins_root = $collectd::plugins_root,
  $collectd_owner = $collectd::owner,
  $collectd_group = $collectd::group,
){
  validate_string($type)
  validate_array($lines)

  # generic plugin
  $plugin_ensure = $onlyif ? {
    true      => 'present',
    false     => 'absent',
    'true'    => 'present',
    'false'   => 'absent',
    default   => fail('Expecting true or false for onlyif parameter'),
  }
  file { "${collectd_plugins_root}/${name}.conf":
    ensure  => $plugin_ensure,
    mode    => '0644',
    owner   => $collectd_owner,
    group   => $collectd_group,
    content => template("${module_name}/plugin_generic.conf.erb"),
    notify  => Service['collectd'],
  }
}
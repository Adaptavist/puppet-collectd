# === Examples
#
#  class { collectd:  }
#
# Hiera configuration:
#  collectd::server::listen_host: "0.0.0.0"
#  collectd::server::listen_port: 25826
#  collectd::client::server_host: "graphite.vagrant.local"
#  collectd::client::server_port: 25826
#
# === Copyright
#
# Copyright 2011 Adaptavist, unless otherwise noted.
#
class collectd(
  $ensure           = present,
  $owner            = 'root',
  $group            = 0,
  $conf_dir         = undef,
  $plugins_dir      = undef,
  $server_host      = '127.0.0.1',
  $server_port      = '25826',
  $latest_se_policy = false,
){

  $install_dir = $::operatingsystem ? {
    /(Ubuntu|debian)/ => '/etc/collectd',
    default => '/etc/collectd.d',
  }

  $included_conf = $::operatingsystem ? {
    /(Ubuntu|debian)/ => ['filters.conf', 'thresholds.conf',],
    default => [],
  }

  if $conf_dir == undef {
    $conf_file = $::operatingsystem ? {
      /(Ubuntu|debian)/ => "${install_dir}/collectd.conf",
      default => '/etc/collectd.conf',
    }
  }
  else { $conf_file = $conf_dir }

  $plugins_root = $plugins_dir ? {
    undef   => "${install_dir}/plugins",
    default => $plugins_dir,
  }

  $se_policy_package = $::operatingsystem ? {
    /(Ubuntu|debian)/ => 'selinux-policy-default',
    default => 'selinux-policy-targeted',
  }

  class { 'collectd::packages': } -> class { 'collectd::configuration': } ~> class { 'collectd::services': } -> Class['collectd']
}

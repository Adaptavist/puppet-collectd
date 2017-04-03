class collectd::plugin::apache(
  $url        = 'http://localhost/server-status',
  $package    = 'collectd-apache',
  $use_plugin = true,
  ) {

  # if this plugin is needed, use it
  if (str2bool($use_plugin)) {
    # if this is running on centos 7 install the additional package to provide apache support
    if ($::osfamily == 'RedHat' and versioncmp($::operatingsystemrelease,'7') >= 0 and $::operatingsystem != 'Fedora') {
      package { $package:
        before => Service['collectd']
      }
    }
  }
  collectd::plugin { 'apache':
    type   => 'apache',
    lines  => [
              '<Instance "apache">',
              "  URL \"${url}?auto\"",
              '</Instance>'
              ],
    onlyif => $use_plugin,
  }
}

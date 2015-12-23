class collectd::plugin::apache(
  $url = 'http://localhost/server-status',
  ) {
  collectd::plugin { 'apache':
    type  => 'apache',
    lines => [
              '<Instance "apache">',
              "  URL \"${url}?auto\"",
              '</Instance>'
              ],
  }
}

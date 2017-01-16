define collectd::plugin::jmx::register(
    $content = '',
    $order   = '10',
    $target  = $collectd::plugin::jmx::conf_file) {
  concat::fragment { "jmx_fragment_${name}":
    target  => $target,
    content => "${content}\n",
    order   => $order,
  }
}

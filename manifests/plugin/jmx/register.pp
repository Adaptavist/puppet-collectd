define collectd::plugin::jmx::register($content='', $order='10') {
  concat::fragment { "jmx_fragment_${name}":
    target  => $collectd::plugin::jmx::conf_file,
    content => "${content}\n",
    order   => $order,
  }
}

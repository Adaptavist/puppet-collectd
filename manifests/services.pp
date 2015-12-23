class collectd::services(
        $collectd_ensure = $collectd::ensure,
    ) {

  $service_ensure = $collectd_ensure ? { present => running, absent  => stopped, default => $collectd_ensure }
  service { 'collectd':
    ensure  => $service_ensure,
    enable  => true,
    pattern => 'collectd',
  }
}

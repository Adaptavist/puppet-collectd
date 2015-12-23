class collectd::packages(
    $ensure_package    = $collectd::ensure,
    $latest_se_policy  = $collectd::latest_se_policy,
    $se_policy_package = $collectd::se_policy_package
    ) {

    package { 'collectd':
        ensure => $ensure_package,
    }

    # if selinux is enabled and the latest_se_policy flag is true, ensure the latest selinux policy package in installed
    if (str2bool($::selinux)) and (str2bool($latest_se_policy)) {
        ensure_resource ('package', $se_policy_package, { ensure => 'latest'})
    }

}

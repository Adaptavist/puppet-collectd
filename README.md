# CollectD module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-collectd.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-collectd)

The collectd parametized class installs a collectd agent on Ubuntu and CentOS
linux, and can be customized to monitor various server statistics and health
of various services.

The collectd::server class receives data from other collectd agents via the
network, and can optionally write it into graphite. (collectd 5.x required)

CollectD has various plugins that can be configured via hiera and activated
to collectd specific data.

On RedHat/CentOS 6 systems the "collectd_tcp_network_connect" se boolean
is not found in earlie version of the selinux policy packages (selinux-policy-targeted),
for example its not in the 3.7.19-231.el6_5.1 package that is shiped with 6.5.
The collectd::latest_se_policy flag (set to false by default) allows for the package
to be updated to the latest version, at the time of writing the latest version
is 3.7.19-260.el6_6. which DOES include the "collectd_tcp_network_connect" se boolean.

## Repositories

This module assumes that a repository exists with collectd present in it. For
CentOS this means using the rpmforge-testing repository. For example:

    yum::managed_yumrepo { 'repoforgetesting':
      descr    => 'RepoForge testing packages',
      baseurl  => 'http://apt.sw.be/redhat/el$releasever/en/$basearch/testing',
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
      priority => 1,
      exclude  => 'perl-IO-Compress-* perl-DBD-MySQL',
    }

## Usage Example

    # for each linux server, just include the collectd class
    class { "collectd":
        server_host => "collectd-server.example.com"
    }

    or hiera equivalent

    collectd::server_host: "collectd-server.example.com"

    # for your central collectd server, include the collectd::server class
    class { "collectd::server":
        write_graphite => true,
        graphite_host => "graphite-server.example.com"
    }

    # to use a jmx plugin, include the collectd::plugin::jmx class
    # its configuration is in hiera/global/collectd.yaml
    class { "collectd::plugins::jmx": }

    # to use different plugins, include their code -
    # see source of manifests/plugin/cpu.pp for an example of new plugins
    include collectd::plugin::cpu
    include collectd::plugin::df
    include collectd::plugin::disk
    collectd::plugin { "load": type => "load" }

    # to update the selinux policy package to the latest
    class { "collectd":
        latest_se_policy => true
    }

    or hiera equivalent

    collectd::latest_se_policy: true


## Authors

Evgeny Zislis <evgeny@devops.co.il>

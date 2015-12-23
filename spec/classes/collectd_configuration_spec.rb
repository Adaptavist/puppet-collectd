require 'spec_helper'
 
collectd_conf_file = '/etc/collectd.conf'
collectd_ensure_absent = 'absent'
collectd_ensure_present = 'present'
collectd_ensure_default = 'default'
install_dir = '/etc/collectd.d'
collectd_plugins_root = "#{install_dir}/plugins"
included_conf = ['filters.conf', 'thresholds.conf',]
collectd_owner = 'guest'
collectd_group = 'guests'

describe 'collectd::configuration', :type => 'class' do
    let (:default_params) { {
        :collectd_ensure => collectd_ensure_absent,
        :collectd_conf_file => collectd_conf_file,
        :collectd_plugins_root => collectd_plugins_root,
        :collectd_install_dir => install_dir,
        :collectd_included_conf => included_conf,
      } }

    context "collectd_ensure is absent" do
      let (:params) do default_params end
        
      it do
        should contain_file(collectd_conf_file).with_ensure(collectd_ensure_absent)
        should contain_file(collectd_plugins_root).with_ensure(collectd_ensure_absent)
      end
    end

    context "collectd_ensure is present" do
      let (:params) do
          default_params.merge({ :collectd_ensure => collectd_ensure_present,
          :collectd_owner => collectd_owner,
          :collectd_group => collectd_group, }) 
        end
          
      it do
        should contain_file(collectd_conf_file).with_ensure(collectd_ensure_present).with(
            'mode'   => '0644',
            'owner'  => collectd_owner,
            'group'  => collectd_group,
          ).with_content(/LoadPlugin syslog/)
          .with_content(/<Plugin syslog>/)
          .with_content(/LogLevel info/)
          .with_content(/<\/Plugin>/)
          .with_content(/"#{collectd_plugins_root}\/\*\.conf"/)
          .with_content(/Include \"#{install_dir}\/filters.conf\"/)
          .with_content(/Include \"#{install_dir}\/thresholds.conf\"/)

        should contain_file(collectd_plugins_root).with(
          'ensure' => 'directory',
          'mode'   => '0755',
          'owner'  => collectd_owner,
          'group'  => collectd_group
          )
      end
    end 
end

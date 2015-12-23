require 'spec_helper'
 

install_dir_redhat = '/etc/collectd.d'
install_dir_ubuntu = '/etc/collectd'
included_conf_ubuntu = ['filters.conf', 'thresholds.conf']
included_conf_other = []

conf_file_ubuntu = "#{install_dir_ubuntu}/collectd.conf"
conf_file_other = '/etc/collectd.conf'

collectd_ensure_present = 'present'
collectd_plugins_root_redhat = "#{install_dir_redhat}/plugins"
collectd_plugins_root_ubuntu = "#{install_dir_ubuntu}/plugins"
collectd_plugins_root = '/etc/collectd_default/plugins'

def check_classes
    it do
      contain_class('collectd::dependencies').that_comes_before('Class[collectd::packages]')
      contain_class('collectd::packages').that_comes_before('Class[collectd::configuration]')
      contain_class('collectd::configuration').that_comes_before('Class[collectd::services]')
      contain_class('collectd::services').that_comes_before('Class[collectd]')
    end
end

describe 'collectd', :type => 'class' do
    let (:default_params) { {} }

    ['Ubuntu','debian'].each do |os|
      context "when $operatingsystem is #{os}" do
        let :facts do default_params.merge({ :operatingsystem => os }) end
        check_classes
        it do
          should contain_file(conf_file_ubuntu).with_ensure(collectd_ensure_present)
          .with_content(/"#{collectd_plugins_root_ubuntu}\/\*\.conf"/)
          .with_content(/Include \"#{install_dir_ubuntu}\/filters.conf\"/)
          .with_content(/Include \"#{install_dir_ubuntu}\/thresholds.conf\"/)
          should contain_file(collectd_plugins_root_ubuntu).with_ensure('directory')
        end
      end
    end

    ['RedHat','redhat'].each do |os|
      context "when $operatingsystem is #{os}" do
        let :facts do default_params.merge({ :operatingsystem => os }) end
        check_classes
        it do
          should contain_file(conf_file_other).with_ensure(collectd_ensure_present)
          .with_content(/"#{collectd_plugins_root_redhat}\/\*\.conf"/)
          should contain_file(collectd_plugins_root_redhat).with_ensure('directory')
        end
      end
    end

    context "when $operatingsystem is CentOS" do
      let(:facts) { {:operatingsystem => 'CentOS'} }
        check_classes
        it do 
          should contain_file(conf_file_other).with_ensure(collectd_ensure_present)
          .with_content(/"#{collectd_plugins_root_redhat}\/\*\.conf"/)
          should contain_file(collectd_plugins_root_redhat).with_ensure('directory')
        end
    end
end

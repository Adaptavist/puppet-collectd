require 'spec_helper'
 
collectd_ensure_absent = 'absent'
collectd_ensure_present = 'present'
collectd_ensure_default = 'default'

describe 'collectd::services', :type => 'class' do

    context "collectd_ensure is absent service should be stopped" do
      let (:params) {{
          :collectd_ensure => collectd_ensure_absent,
        }}
      it do
        should contain_service('collectd').with_ensure('stopped')
      end
    end

    context "collectd_ensure is present service should be running" do
      let (:params) {{
          :collectd_ensure => collectd_ensure_present,
        }}
      it do
        should contain_service('collectd').with_ensure('running')
      end
    end

    context "collectd_ensure is something else service should be set to something else" do
      let (:params) {{
          :collectd_ensure => collectd_ensure_default,
        }}
      it do
        should contain_service('collectd').with_ensure(collectd_ensure_default)
      end
    end
    
end

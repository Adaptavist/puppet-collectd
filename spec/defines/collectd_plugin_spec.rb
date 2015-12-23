require 'spec_helper'

type = 'interface'
lines = ["Interface \"lo\"","IgnoreSelected true"]
interval = 3
def_collectd_plugins_root = ''
collectd_plugins_root = '/etc/collectd'

def_title = 'interface'
collectd_owner = "guest"
collectd_group = "guests"

describe 'collectd::plugin', :type => 'define' do
    let :title do
      def_title
    end

    context "should set ensure to absent for plugin file in case onlyif is false" do
      let (:params) {{
          :onlyif => false,
        }}

      it do
        should contain_file("#{def_collectd_plugins_root}/#{def_title}.conf").with_ensure('absent')
      end
    end

    context "should set default values for plugin correctly" do
      let (:params) {{
          :collectd_owner => collectd_owner,
          :collectd_group => collectd_group,
        }}

      it do
        should contain_file("#{def_collectd_plugins_root}/#{def_title}.conf").with_ensure('present').with(
          'mode'    => '0644',
          'owner'   => collectd_owner,
          'group'   => collectd_group,
          'notify'  => 'Service[collectd]',
          ).with_content(/LoadPlugin ""/)
      end
    end

    context "should create correct plugin file with params set" do
      let (:params) {{
          :onlyif => true,
          :collectd_owner => collectd_owner,
          :collectd_group => collectd_group,
          :type => type,
          :lines => lines,
          :interval => interval,
          :collectd_plugins_root => collectd_plugins_root,
        }}

      it do
        should contain_file("#{collectd_plugins_root}/#{def_title}.conf").with_ensure('present').with(
          'mode'    => '0644',
          'owner'   => collectd_owner,
          'group'   => collectd_group,
          'notify'  => 'Service[collectd]',
          ).with_content(/LoadPlugin "#{type}"/)
          .with_content(/Interval #{interval}/)
          .with_content(/<\/LoadPlugin>/)
          .with_content(/<Plugin "#{type}">/)
          .with_content(/#{lines.join("\n  ")}/)
          .with_content(/<\/Plugin>/)
      end
    end

end

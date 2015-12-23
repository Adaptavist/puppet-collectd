require 'spec_helper'
 
server_host = '0.0.0.0'
server_port = '25826'

describe 'collectd::client', :type => 'class' do
    let (:default_params) {{
      :server_host => server_host,
      :server_port => server_port,
    }}

    context "should contain collectd class" do
      let (:params) do default_params end
      it do
        should contain_class('collectd')
      end
    end

    context "should contain collectd client plugin" do
      let (:params) do default_params end
      it do
        should contain_collectd__plugin('client').with(
          'type' => 'network',
          'lines' => "Server \"#{server_host}\" \"#{server_port}\""
        )
      end
    end

end

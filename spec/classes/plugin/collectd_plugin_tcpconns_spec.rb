require 'spec_helper'

describe 'collectd::plugin::tcpconns', :type => 'class' do
    
    context "should raise error if localports is not an array" do
      let (:params){{ :localports => '1234'}}
      it { expect { should contain_collectd__plugin('tcpconns') }.to raise_error(Puppet::Error) }
    end
    context "should raise error if remoteports is not an array" do
      let (:params){{ :remoteports => '1234'}}
      it { expect { should contain_collectd__plugin('tcpconns') }.to raise_error(Puppet::Error) }
    end
    context "should initialize define collectd_plugin with params for tcpconns" do
      let (:params){{ 
        :localports => ['1234', '4321'],
        :remoteports => ['2345', '5432'],
        }}
      it do
        should contain_collectd__plugin('tcpconns').with(
          'type' => 'tcpconns',
          'lines' => ["ListeningPorts true", "LocalPort 1234", "LocalPort 4321", "RemotePort 2345", "RemotePort 5432"]
        )
      end
    end

end

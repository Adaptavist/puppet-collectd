require 'spec_helper'

describe 'collectd::plugin::processes', :type => 'class' do
    
    context "should raise error if processes param is not an array" do
      let (:params){{ :processes => 'process2'}}
      it { expect { should contain_collectd__plugin('processes') }.to raise_error(Puppet::Error) }
    end

    context "should initialize define collectd_plugin with params for processes" do
      let (:params){{ :processes => ['process1', 'process2']}}
      it do
        should contain_collectd__plugin('processes').with(
          'type' => 'processes',
          'lines' => ["Process process1", "Process process2"]
        )
      end
    end

end

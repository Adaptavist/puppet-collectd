require 'spec_helper'

describe 'collectd::plugin::cpu', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for cpu" do
      it do
        should contain_collectd__plugin('cpu').with(
          'type' => 'cpu',
        )
      end
    end

end

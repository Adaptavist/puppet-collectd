require 'spec_helper'

describe 'collectd::plugin::memory', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for memory" do
      it do
        should contain_collectd__plugin('memory').with(
          'type' => 'memory',
        )
      end
    end

end

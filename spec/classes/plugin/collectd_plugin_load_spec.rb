require 'spec_helper'

describe 'collectd::plugin::load', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for load" do
      it do
        should contain_collectd__plugin('load').with(
          'type' => 'load',
        )
      end
    end

end

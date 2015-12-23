require 'spec_helper'

describe 'collectd::plugin::users', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for users" do
      it do
        should contain_collectd__plugin('users').with(
          'type' => 'users',
        )
      end
    end

end

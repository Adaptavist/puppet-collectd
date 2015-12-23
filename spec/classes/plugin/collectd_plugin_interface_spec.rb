require 'spec_helper'

describe 'collectd::plugin::interface', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for interface" do
      it do
        should contain_collectd__plugin('interface').with(
          'type' => 'interface',
          'lines' => [
		      "Interface \"lo\"",
		      "IgnoreSelected true"
		    ]
        )
      end
    end

end

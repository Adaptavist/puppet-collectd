require 'spec_helper'

describe 'collectd::plugin::disk', :type => 'class' do
    
    context "should initialize define collectd_plugin with params for disk" do
      it do
        should contain_collectd__plugin('disk').with(
          'type' => 'disk',
          'lines' => [
		      "Disk \"/(h|s|xv)da[1234]/\"",
		      "IgnoreSelected false"
		    ]
        )
      end
    end

end

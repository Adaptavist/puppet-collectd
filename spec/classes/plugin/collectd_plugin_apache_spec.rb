require 'spec_helper'

url = 'http://www.adaptavist.com/server-status'
def_url = 'http://localhost/server-status'

def_lines = ["<Instance \"apache\">", "  URL \"#{def_url}?auto\"", "</Instance>"]
lines = ["<Instance \"apache\">", "  URL \"#{url}?auto\"", "</Instance>"]


describe 'collectd::plugin::apache', :type => 'class' do
    
    context "should initialize define collectd_plugin with default params for apache" do
      it do
        should contain_collectd__plugin('apache').with(
          'type' => 'apache',
          'lines' => def_lines,
        )
      end
    end

    context "should initialize define collectd_plugin with custom params for apache" do
      let (:params) {{
          :url => url,
        }}

      it do
        should contain_collectd__plugin('apache').with(
          'type' => 'apache',
          'lines' => lines,
        )
      end
    end

end

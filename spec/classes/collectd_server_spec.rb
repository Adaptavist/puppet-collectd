require 'spec_helper'
 
def_listen_host = '0.0.0.0'
def_listen_port = '25826'
listen_host = 'www.adaptavist.com'
listen_port = '25827'

def_write_graphite = true
def_graphite_host = '127.0.0.1'
def_graphite_port = '2003'
def_graphite_prefix = 'collectd.'
def_graphite_postfix = ''
def_graphite_protocol = 'tcp'

graphite_host    = 'www.adaptavist.com'
graphite_port    = '2004'
graphite_prefix  = 'collectd_prefix.'
graphite_postfix = 'postfix'
graphite_protocol = 'udp'

describe 'collectd::server', :type => 'class' do
    let (:default_params) {{
      :listen_host => def_listen_host,
      :listen_port => def_listen_port,
    }}

    context "should contain collectd class" do
      it do
        should contain_class('collectd')
      end
    end

    context "should contain collectd server_network_listen plugin with default params" do
      let (:params) do default_params end
      it do
        should contain_collectd__plugin('server_network_listen').with(
          'type' => 'network',
          'lines' => "Listen \"#{def_listen_host}\" \"#{def_listen_port}\"",
        )
      end
    end

    context "should contain collectd server_network_listen plugin with custom params" do
      let (:params)  {{
        :listen_host => listen_host,
        :listen_port => listen_port,
      }}
      it do
        should contain_collectd__plugin('server_network_listen').with(
          'type' => 'network',
          'lines' => "Listen \"#{listen_host}\" \"#{listen_port}\"",
        )
      end
    end

    context "should contain collectd server_graphite_write plugin with default params" do
      it do
        should contain_collectd__plugin('server_graphite_write').with(
          'onlyif'  => def_write_graphite,
          'type' => 'write_graphite',
          'lines' => [
              "<Carbon>",
              "  Host \"#{def_graphite_host}\"",
              "  Port \"#{def_graphite_port}\"",
              "  Protocol \"#{def_graphite_protocol}\"",
              "  Prefix \"#{def_graphite_prefix}\"",
              "  Postfix \"#{def_graphite_postfix}\"",
              "</Carbon>"
            ]
          )
      end
    end

    context "should contain collectd server_graphite_write plugin with custom params" do
      let (:params)  {{
        :write_graphite   => def_write_graphite,
        :graphite_host    => graphite_host,
        :graphite_port    => graphite_port,
        :graphite_prefix  => graphite_prefix,
        :graphite_postfix => graphite_postfix,
        :graphite_protocol => graphite_protocol,
      }}
      it do
        should contain_collectd__plugin('server_graphite_write').with(
          'onlyif' => def_write_graphite,
          'type' => 'write_graphite',
          'lines' => [
              "<Carbon>",
              "  Host \"#{graphite_host}\"",
              "  Port \"#{graphite_port}\"",
              "  Protocol \"#{graphite_protocol}\"",
              "  Prefix \"#{graphite_prefix}\"",
              "  Postfix \"#{graphite_postfix}\"",
              "</Carbon>"
            ]
          )
      end
    end

    context "should not contain collectd server_graphite_write plugin if write_graphite is false" do
      let (:params)  {{
        :write_graphite => false,
      }}
      it do
        should contain_collectd__plugin('server_graphite_write').with(
          'onlyif' => false,
          )
      end
    end
end

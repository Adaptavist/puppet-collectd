require 'spec_helper'

def_title   = 'atlassian_jira'
host        = 'www.adaptavist.com'
port        = '1234'
service_url = 'service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi'
def_service_url = "service:jmx:rmi:///jndi/rmi://${host}:${port}/jmxrmi"
user        = 'user'
password    = 'passwd'

target = "target"

collect = [ 'classes',
            'compilation',
            'garbage_collector',
            'memory',
            'memory_pool',
            'catalina_thread_pool',
            'catalina_global_request_processor'
        ]

def_collect = [ 'classes', 'compilation',
          'garbage_collector', 'memory',
          'memory_pool' ]

describe 'collectd::plugin::jmx::connection', :type => 'define' do
    let :title do
      def_title
    end
    let(:facts) {{
        :concat_basedir => '/tmp'
    }}
    let(:params){{
        :target => target
    }}

    context "should work with default parameters, check default collection" do
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 30,
        ).with_content(/<Connection>/)
        .with_content(/ServiceURL service:jmx:rmi:\/\/\/jndi\/rmi:\/\/:\/jmxrmi/)
        .with_content(/Collect \"#{def_collect[0]}\"/)
        .with_content(/Collect \"#{def_collect[1]}\"/)
        .with_content(/Collect \"#{def_collect[2]}\"/)
        .with_content(/Collect \"#{def_collect[3]}\"/)
        .with_content(/Collect \"#{def_collect[4]}\"/)
        .with_content(/<\/Connection>/)
      end
    end

    context "should craete contain_collectd__plugin__jmx__register with service url based on host and port" do
    let(:params){{
        :host => host,
        :port => port,
        :target => target
        }}
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 30,
        ).with_content(/<Connection>/)
        .with_content(/ServiceURL service:jmx:rmi:\/\/\/jndi\/rmi:\/\/#{host}:#{port}\/jmxrmi/)
        .with_content(/Host \"#{host}\"/)
        .with_content(/Port \"#{port}\"/)
        .with_content(/Collect \"#{def_collect[0]}\"/)
        .with_content(/Collect \"#{def_collect[1]}\"/)
        .with_content(/Collect \"#{def_collect[2]}\"/)
        .with_content(/Collect \"#{def_collect[3]}\"/)
        .with_content(/Collect \"#{def_collect[4]}\"/)
        .with_content(/<\/Connection>/)
      end
    end

    context "should craete contain_collectd__plugin__jmx__register based on parameters" do
    let(:params){{
        :service_url => service_url,
        :host => host,
        :port => port,
        :collect => collect,
        :target => target
        }}
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 30,
        ).with_content(/<Connection>/)
        .with_content(/ServiceURL #{service_url}/)
        .with_content(/Host \"#{host}\"/)
        .with_content(/Port \"#{port}\"/)
        .with_content(/Collect \"#{collect[0]}\"/)
        .with_content(/Collect \"#{collect[1]}\"/)
        .with_content(/Collect \"#{collect[2]}\"/)
        .with_content(/Collect \"#{collect[3]}\"/)
        .with_content(/Collect \"#{collect[4]}\"/)
        .with_content(/Collect \"#{collect[5]}\"/)
        .with_content(/Collect \"#{collect[6]}\"/)
        .with_content(/<\/Connection>/)
      end
    end

end

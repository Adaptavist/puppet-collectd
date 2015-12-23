require 'spec_helper'

def_title = 'classes'
object_name = 'java.lang:type=MemoryPool'
instance_prefix = 'memory_pool-'
instance_from = 'name'
value = {
    'type' => 'jmx_memory',
    'table' => true,
    'attribute' => 'Usage'
}

values = [
            {
            'type' => 'jmx_memory',
            'instance_prefix' => 'heap-',
            'table' => true,
            'attribute' => 'HeapMemoryUsage'
            },
            {
            'type' => 'jmx_memory',
            'instance_prefix' => 'nonheap-',
            'table' => true,
            'attribute'=> 'NonHeapMemoryUsage'
            }
        ]
describe 'collectd::plugin::jmx::mbean', :type => 'define' do
    let :title do
      def_title
    end
    let :facts do
    {
      :concat_basedir => '/tmp'
    }
    end

    context "should require object_name as parameter" do
        it { expect { should contain_collectd__plugin__jmx__register(def_title) }.to raise_error(Puppet::Error) }
    end

    context "should work with default parameters" do
    let(:params){{ :object_name => object_name}}
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 20,
        ).with_content(/<MBean \"classes\">/)
        .with_content(/ObjectName \"#{object_name}\"/)
        .with_content(/<Value>/)
        .with_content(/Type/)
        .with_content(/Attribute/)
        .with_content(/<\/Value>/)
        .with_content(/<\/MBean>/)
      end
    end

    context "should with param values not defined as default" do
    let(:params){{
        :object_name => object_name,
        :instance_prefix => instance_prefix,
        :instance_from => instance_from,
        :value => value,
        }}
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 20,
        ).with_content(/<MBean \"classes\">/)
        .with_content(/ObjectName \"#{object_name}\"/)
        .with_content(/InstancePrefix \"#{instance_prefix}\"/)
        .with_content(/<Value>/)
        .with_content(/Type \"#{value['type']}\"/)
        .with_content(/InstanceFrom \"#{value['table']}\"/)
        .with_content(/Attribute \"#{value['attribute']}\"/)
        .with_content(/<\/Value>/)
        .with_content(/<\/MBean>/)

        end
    end

    context "should use values array in case it is defined" do
    let(:params){{
        :object_name => object_name,
        :instance_prefix => instance_prefix,
        :instance_from => instance_from,
        :value => value,
        :values => values,
        }}
    it do
        should contain_collectd__plugin__jmx__register(def_title).with(
          'order' => 20,
        ).with_content(/<MBean \"classes\">/)
        .with_content(/ObjectName \"#{object_name}\"/)
        .with_content(/InstancePrefix \"#{instance_prefix}\"/)
        .with_content(/<Value>/)
        .with_content(/Type \"#{values[0]['type']}\"/)
        .with_content(/InstanceFrom \"#{values[0]['table']}\"/)
        .with_content(/Attribute \"#{values[0]['attribute']}\"/)
        .with_content(/<\/Value>/)
        .with_content(/Type \"#{values[1]['type']}\"/)
        .with_content(/InstanceFrom \"#{values[1]['table']}\"/)
        .with_content(/Attribute \"#{values[1]['attribute']}\"/)
        .with_content(/<\/MBean>/)

        end
    end

end

require 'spec_helper'
 
describe 'collectd::packages', :type => 'class' do
  	
  	context "Should not have package collectd installed" do
		let(:params) { {:ensure_package => 'absent'} }
		it do 
			should contain_package('collectd').with_ensure('absent')
		end
	end

	context "Should install package, based on param" do
		let(:params) { {:ensure_package => 'present'} }
		it do 
			should contain_package('collectd').with_ensure('present')
		end
	end

	context "Should install package, and update selinux policy packge" do
		let(:params) { 
			{
				:ensure_package    => 'present',
                :latest_se_policy  => true,
                :se_policy_package => 'selinux-policy-targeted',
			} 
		}
		let(:facts) { 
			{
				:selinux           => true,
				:operatingsystem   => 'RedHat',
			} 
		}
		it do 
			should contain_package('collectd').with_ensure('present')
			should contain_package('selinux-policy-targeted').with_ensure('latest')
		end
	end

	context "Should install package, and not update selinux policy packge" do
		let(:params) { 
			{
				:ensure_package    => 'present',
                :latest_se_policy  => true,
                :se_policy_package => 'selinux-policy-targeted',
			} 
		}
		let(:facts) { 
			{
				:selinux           => false,
				:operatingsystem   => 'RedHat',
			} 
		}
		it do 
			should contain_package('collectd').with_ensure('present')
			should_not contain_package('selinux-policy-targeted')
		end
	end

end

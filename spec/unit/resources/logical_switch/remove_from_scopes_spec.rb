require_relative './../../../spec_helper'

describe 'oneview_test_api300_synergy::logical_switch_remove_from_scopes' do
  let(:resource_name) { 'logical_switch' }
  include_context 'chef context'

  let(:target_class) { OneviewSDK::API300::C7000::LogicalSwitch }
  let(:scope_class) { OneviewSDK::API300::C7000::Scope }
  let(:target_match_method) { [:remove_oneview_logical_switch_from_scopes, 'LogicalSwitch1'] }
  it_behaves_like 'action :remove_from_scopes'
end

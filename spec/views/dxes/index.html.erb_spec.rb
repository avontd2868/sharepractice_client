require 'spec_helper'

describe "dxes/index" do
  before(:each) do
    assign(:dxes, [
      stub_model(Dx,
        :name => "Name",
        :definition => "Definition",
        :dx_code => "Dx Code",
        :codes => "Codes",
        :resource_uri => "Resource Uri"
      ),
      stub_model(Dx,
        :name => "Name",
        :definition => "Definition",
        :dx_code => "Dx Code",
        :codes => "Codes",
        :resource_uri => "Resource Uri"
      )
    ])
  end

  it "renders a list of dxes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Definition".to_s, :count => 2
    assert_select "tr>td", :text => "Dx Code".to_s, :count => 2
    assert_select "tr>td", :text => "Codes".to_s, :count => 2
    assert_select "tr>td", :text => "Resource Uri".to_s, :count => 2
  end
end

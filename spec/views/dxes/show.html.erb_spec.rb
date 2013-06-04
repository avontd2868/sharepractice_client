require 'spec_helper'

describe "dxes/show" do
  before(:each) do
    @dx = assign(:dx, stub_model(Dx,
      :name => "Name",
      :definition => "Definition",
      :dx_code => "Dx Code",
      :codes => "Codes",
      :resource_uri => "Resource Uri"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Definition/)
    rendered.should match(/Dx Code/)
    rendered.should match(/Codes/)
    rendered.should match(/Resource Uri/)
  end
end

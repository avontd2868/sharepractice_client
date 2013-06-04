require 'spec_helper'

describe "dxes/new" do
  before(:each) do
    assign(:dx, stub_model(Dx,
      :name => "MyString",
      :definition => "MyString",
      :dx_code => "MyString",
      :codes => "MyString",
      :resource_uri => "MyString"
    ).as_new_record)
  end

  it "renders new dx form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dxes_path, "post" do
      assert_select "input#dx_name[name=?]", "dx[name]"
      assert_select "input#dx_definition[name=?]", "dx[definition]"
      assert_select "input#dx_dx_code[name=?]", "dx[dx_code]"
      assert_select "input#dx_codes[name=?]", "dx[codes]"
      assert_select "input#dx_resource_uri[name=?]", "dx[resource_uri]"
    end
  end
end

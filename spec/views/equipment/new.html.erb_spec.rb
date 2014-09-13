require 'rails_helper'

RSpec.describe "equipment/new", :type => :view do
  before(:each) do
    assign(:equipment, Equipment.new(
      :project => nil,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new equipment form" do
    render

    assert_select "form[action=?][method=?]", equipment_index_path, "post" do

      assert_select "input#equipment_project_id[name=?]", "equipment[project_id]"

      assert_select "input#equipment_name[name=?]", "equipment[name]"

      assert_select "input#equipment_description[name=?]", "equipment[description]"
    end
  end
end

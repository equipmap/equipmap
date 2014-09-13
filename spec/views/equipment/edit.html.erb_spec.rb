require 'rails_helper'

RSpec.describe "equipment/edit", :type => :view do
  before(:each) do
    @equipment = assign(:equipment, Equipment.create!(
      :project => nil,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit equipment form" do
    render

    assert_select "form[action=?][method=?]", equipment_path(@equipment), "post" do

      assert_select "input#equipment_project_id[name=?]", "equipment[project_id]"

      assert_select "input#equipment_name[name=?]", "equipment[name]"

      assert_select "input#equipment_description[name=?]", "equipment[description]"
    end
  end
end

require 'rails_helper'

RSpec.describe "locations/new", :type => :view do
  before(:each) do
    assign(:location, Location.new(
      :coordinates => ""
    ))
  end

  it "renders new location form" do
    render

    assert_select "form[action=?][method=?]", locations_path, "post" do

      assert_select "input#location_coordinates[name=?]", "location[coordinates]"
    end
  end
end

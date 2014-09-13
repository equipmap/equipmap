require 'rails_helper'

RSpec.describe "equipment/index", :type => :view do
  before(:each) do
    assign(:equipment, [
      Equipment.create!(
        :project => nil,
        :name => "Name",
        :description => "Description"
      ),
      Equipment.create!(
        :project => nil,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of equipment" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end

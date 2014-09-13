require 'rails_helper'

RSpec.describe "equipment/show", :type => :view do
  before(:each) do
    @equipment = assign(:equipment, Equipment.create!(
      :project => nil,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end

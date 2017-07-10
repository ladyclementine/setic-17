require 'rails_helper'

RSpec.describe "crew/events/index", type: :view do
  before(:each) do
    assign(:crew_events, [
      Crew::Event.create!(
        :name => "Name",
        :limit => 2,
        :description => "MyText",
        :facilitator => "Facilitator"
      ),
      Crew::Event.create!(
        :name => "Name",
        :limit => 2,
        :description => "MyText",
        :facilitator => "Facilitator"
      )
    ])
  end

  it "renders a list of crew/events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Facilitator".to_s, :count => 2
  end
end

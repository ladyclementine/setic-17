require 'rails_helper'

RSpec.describe "crew/events/new", type: :view do
  before(:each) do
    assign(:crew_event, Crew::Event.new(
      :name => "MyString",
      :limit => 1,
      :description => "MyText",
      :facilitator => "MyString"
    ))
  end

  it "renders new crew_event form" do
    render

    assert_select "form[action=?][method=?]", crew_events_path, "post" do

      assert_select "input#crew_event_name[name=?]", "crew_event[name]"

      assert_select "input#crew_event_limit[name=?]", "crew_event[limit]"

      assert_select "textarea#crew_event_description[name=?]", "crew_event[description]"

      assert_select "input#crew_event_facilitator[name=?]", "crew_event[facilitator]"
    end
  end
end

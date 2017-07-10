require 'rails_helper'

RSpec.describe "crew/events/edit", type: :view do
  before(:each) do
    @crew_event = assign(:crew_event, Crew::Event.create!(
      :name => "MyString",
      :limit => 1,
      :description => "MyText",
      :facilitator => "MyString"
    ))
  end

  it "renders the edit crew_event form" do
    render

    assert_select "form[action=?][method=?]", crew_event_path(@crew_event), "post" do

      assert_select "input#crew_event_name[name=?]", "crew_event[name]"

      assert_select "input#crew_event_limit[name=?]", "crew_event[limit]"

      assert_select "textarea#crew_event_description[name=?]", "crew_event[description]"

      assert_select "input#crew_event_facilitator[name=?]", "crew_event[facilitator]"
    end
  end
end

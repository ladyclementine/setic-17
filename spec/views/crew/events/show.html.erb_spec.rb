require 'rails_helper'

RSpec.describe "crew/events/show", type: :view do
  before(:each) do
    @crew_event = assign(:crew_event, Crew::Event.create!(
      :name => "Name",
      :limit => 2,
      :description => "MyText",
      :facilitator => "Facilitator"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Facilitator/)
  end
end

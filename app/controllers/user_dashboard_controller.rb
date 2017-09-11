class UserDashboardController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion, :except=>[:about]

  def index
    #@days = Event.join_events_by_time
    @days = Event.join_events_by_time
    @comment = Comment.all.order("created_at DESC")
    

  end

  def about
  end

end

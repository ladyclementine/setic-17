class HotelsController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  before_action :if_room_close_redirect
  before_action :user_must_have_paid
  # VERIFICAR SE A PESSOA PAGOU..

  def index
    @ship_users = User.pays.where.not(avatar:nil).order("RANDOM()").limit(4)
  end 

  def admin_on?
    if get_admin.nil?
      redirect_to authenticated_user_root_path
    end
  end

  def get_admin
    @admin = current_crew_admin
  end



end

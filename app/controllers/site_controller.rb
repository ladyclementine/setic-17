class SiteController < ApplicationController
  layout false
  def index
  	render :file => 'public/maintenance.html', :status => 200, :layout => false
  end
end

module UserDashboardHelper
  def room_infos
    if current_user.room.nil?
      link_to hotels_path, class: "pull-right" do
        "Não Selecionado"
      end
    else
      link_to rooms_path(current_user.room.hotel), class: "pull-right", "data-toggle": "tooltip", "title": "", "data-original-title": "#{current_user.room.hotel.name.capitalize}" do
        "Quarto #{current_user.room.number}"
      end
    end
  end

  def width_room
    if !current_user.room.nil?
      case current_user.room.capacity.to_i
      when 2
        '25'
      when 3
        '25'
      when 4
        '25'
      when 6
        '16'
      end
    else
      '25'
    end
  end
  
end

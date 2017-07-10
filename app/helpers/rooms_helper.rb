module RoomsHelper
  #room_name(room.name)
  def room_name_link(room)
    if room.users.include? @user
      link_to 'Editar nome do quarto', 'javascript:void(0)', "data-original-title": "Alterar Nome", "data-toggle": "tooltip", onclick: 'change_name_room('"#{room.id}"', "#{room.name}")'
    end
  end
end

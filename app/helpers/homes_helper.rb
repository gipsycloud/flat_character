module HomesHelper
  def html_link_to_home(room)
    link_to room.address, room__url(room), target: "_blank", style: ''
  end
end

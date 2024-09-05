module RoomsHelper
  # def default_image image
  #   if room.image.present?
  #     cl_image_tag room.image_url :thumbnail
  #   else
  #     image_tag 'default_image.jpg'
  #   end
  # end

  def html_link_to(*arg)
    link_to @room.address, room_path(*arg), target: '_blank', style: 'color: rgb(88 80 236/var(--tw-bg-opacity))'
  end
end

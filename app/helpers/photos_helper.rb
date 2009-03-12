module PhotosHelper

  def photo_snap_path(photo)
    photo_variant_path(photo, "600", :format => "jpg")
  end

  def photo_thumb_path(photo)
    photo_variant_path(photo, "100c", :format => "jpg")
  end

  def photo_thumb(photo)
    photo_image(photo, :thumb)
  end

  def photo_snap(photo)
    photo_image(photo, :snap)
  end
  
  def photo_image(photo, type)
    image_tag(send("photo_#{type}_path", photo), :class => type.to_s, :title => photo.description)
  end

  def photo_link(photo, html_options = {})
    link_to(photo_thumb(photo), photo_path(photo), html_options) if photo
  end

end

module PhotosHelper

  def photo_snap_path(photo)
    formatted_photo_variant_path(photo, "600", "jpg")
  end

  def photo_snap(photo)
    image_tag(photo_snap_path(photo))
  end
  
  def photo_thumb_path(photo)
    formatted_photo_variant_path(photo, "100c", "jpg")
  end

  def photo_thumb(photo)
    image_tag(photo_thumb_path(photo), :class =>"thumb")
  end

  def photo_link(photo, html_options = {})
    link_to(photo_thumb(photo), photo_path(photo), html_options) if photo
  end

end

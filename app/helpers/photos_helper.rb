module PhotosHelper

  def photo_snap_path(photo)
    formatted_photo_variant_path(photo, "600", "jpg")
  end

  def photo_snap(photo)
    image_tag(photo_snap_path(photo))
  end
  
  def photo_thumb_path(photo)
    formatted_photo_variant_path(photo, "150", "jpg")
  end

  def photo_thumb(photo)
    image_tag(photo_thumb_path(photo), :class =>"thumb")
  end

  def photo_link(photo)
    link_to(photo_thumb(photo), photo_path(photo))
  end

end

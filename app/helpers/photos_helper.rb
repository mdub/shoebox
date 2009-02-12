module PhotosHelper

  def photo_snap_path(photo)
    formatted_photo_variant_path(photo, "800", "jpg")
  end

  def photo_thumb_path(photo)
    formatted_photo_variant_path(photo, "150", "jpg")
  end

end

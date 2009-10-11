module PhotosHelper

  def photo_snap_path(photo)
    photo_variant_path(photo, "snap", :format => "jpg")
  end

  def photo_thumb_path(photo)
    photo_variant_path(photo, "thumb", :format => "jpg")
  end

  def photo_thumb(photo)
    photo_image(photo, :thumb)
  end

  def photo_snap(photo)
    photo_image(photo, :snap)
  end
  
  def photo_image(photo, type)
    title = photo.timestamp.to_s(:custom) if photo.timestamp
    image_tag(send("photo_#{type}_path", photo), :class => type.to_s, :title => title)
  end

  def photo_link(photo, html_options = {})
    return nil unless photo
    link_to(photo_thumb(photo), photo_path(photo), html_options) 
  end

end

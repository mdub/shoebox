module PhotosHelper

  def photo_image_path(photo, variant = :snap)
    photo_variant_path(photo, "#{photo.id}-#{variant}", :format => "jpg")
  end

  def photo_image(photo, variant, image_options = {})
    title = photo.taken_at.localtime.to_s(:custom) if photo.taken_at
    image_tag(photo_image_path(photo, variant), image_options.reverse_merge(:class => variant.to_s, :title => title))
  end

  def photo_link(photo, html_options = {})
    return nil unless photo
    link_to(photo_image(photo, :thumb), photo_path(photo), html_options) 
  end

end

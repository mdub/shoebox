class Photo < ActiveRecord::Base

  has_attachment(
  {
    :content_type => :image, 
    :max_size => 2.megabytes,
    :storage => :file_system, 
    :path_prefix => "public/var/#{Rails.env}/photos"
  }
  )

  validates_as_attachment

  def create_thumbnail(filename, size)
    ImageScience.with_image full_filename do |img|
      img.thumbnail(size) do |thumbnail|
        FileUtils.mkpath(File.dirname(filename))
        thumbnail.save(filename)
      end
    end
  end

end

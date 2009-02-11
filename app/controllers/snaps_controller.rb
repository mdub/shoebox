require 'fileutils'

class SnapsController < ApplicationController

  CONTENT_TYPES = {
    "jpg" => "image/jpeg",
    "png" => "image/png"
  }
  
  def show
    @photo = Photo.find(params[:photo_id])
    filename = File.join(Rails.public_path, request.path)
    logger.info("hoping to save #{filename} from #{@photo.full_filename}")
    ImageScience.with_image @photo.full_filename do |img|
      img.thumbnail(800) do |snap|
        logger.info("saving #{filename}")
        FileUtils.mkpath(File.dirname(filename))
        snap.save(filename)
      end
    end
    content_type = CONTENT_TYPES[params[:format]]
    send_file(filename, :type => content_type, :disposition => 'inline')
  end

end

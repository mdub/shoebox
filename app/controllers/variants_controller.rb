require 'fileutils'

class VariantsController < ApplicationController

  session :off

  def show
    find_photo
    rescale
    respond_to do |format|
      format.jpg do
        content_type = Mime::Type.lookup_by_extension(params[:format]).to_s
        logger.info("format #{params[:format].to_sym} type #{content_type}")
        send_file(@rescaled_filename, :type => content_type, :disposition => 'inline')
      end
    end
  end

  private
  
  def find_photo
    @photo = Photo.find(params[:photo_id])
  end
  
  def rescale
    size = params[:id].to_i
    @rescaled_filename = File.join(Rails.public_path, request.path)

    FileUtils.mkpath(File.dirname(@rescaled_filename))
    
    @photo.with_image do |original|
      original.thumbnail(size) do |thumbnail|
        thumbnail.save(@rescaled_filename)
      end
    end

  end
  
end

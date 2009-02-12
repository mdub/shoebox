require 'fileutils'

class SnapsController < ApplicationController

  session :off

  def show
    @photo = Photo.find(params[:photo_id])

    respond_to do |format|
      format.jpg do
        filename = File.join(Rails.public_path, request.path)
        @photo.create_thumbnail(filename, 800)

        content_type = Mime::Type.lookup_by_extension(params[:format]).to_s
        logger.info("format #{params[:format].to_sym} type #{content_type}")
        send_file(filename, :type => content_type, :disposition => 'inline')
      end
    end
  end

end

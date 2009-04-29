require 'fileutils'

class VariantsController < ApplicationController

  before_filter :find_photo, :only => [:show]
  
  def show
    generate_variant
    respond_to do |format|
      format.jpg do
        send_file(@variant_file_name, :type => "image/jpeg", :disposition => 'inline', :stream => true)
        @performed_render = true # TODO:why is this required?
      end
    end
  end

  private
  
  def find_photo
    @photo = Photo.find_by_id(params[:photo_id]) || head(:status => :not_found)
  end
  
  def generate_variant
    image = MiniMagick::Image.from_file(@photo.full_filename)

    size = params[:id].to_i
    image.resize "#{size}x#{size}"

    @variant_file_name = File.join(Rails.public_path, request.path)
    FileUtils.mkpath(File.dirname(@variant_file_name))
    image.run_command("mogrify", "-auto-orient", image.path)
    image.write(@variant_file_name)
  end
  
end

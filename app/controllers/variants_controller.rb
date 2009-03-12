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
    @variant_file_name = File.join(Rails.public_path, request.path)
    FileUtils.mkpath(File.dirname(@variant_file_name))

    variant_key = params[:id]
    op = case variant_key 
    when /^(\d+)$/
      [:thumbnail, $1.to_i]
    when /^(\d+)c$/
      [:cropped_thumbnail, $1.to_i]
    end
    
    @photo.with_image do |original|
      original.send(*op) do |variant|
        variant.save(@variant_file_name)
      end
    end

  end
  
end

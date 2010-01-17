require 'fileutils'

class VariantsController < ApplicationController

  VARIANTS = {
    "snap" => %w(-resize 600x600 -auto-orient -bordercolor snow -border 10),
    "thumb" => %w(-resize 100x100^ -auto-orient -strip -gravity center -extent 100x100),
    "max" => %w(-auto-orient)
  }

  before_filter :resolve_variant
  before_filter :find_photo, :only => [:show]
  
  def show
    variant_file_name = File.join(Rails.public_path, request.path)
    FileUtils.mkpath(File.dirname(variant_file_name))
    @variant_args += [variant_file_name]
    @photo.write_variant(*@variant_args)

    respond_to do |format|
      format.jpg do
        send_file(variant_file_name, :type => "image/jpeg", :disposition => 'inline', :stream => true)
        @performed_render = true # TODO:why is this required?
      end
    end
  end

  private
  
  def resolve_variant
    variant = params[:id]
    @variant_args = VARIANTS[variant] || raise(ActiveRecord::RecordNotFound, "unknown variant, #{variant}")
  end
  
  def find_photo
    @photo = Photo.find_by_id(params[:photo_id]) || head(:status => :not_found)
  end
  
end

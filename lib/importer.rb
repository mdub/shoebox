class Importer

  attr_writer :out
  attr_accessor :archive_dir
  
  def out
    @out || $stdout
  end

  def say(message)
    out.puts(message)
  end
  
  def import(filenames)
    filenames.each do |f|
      import_photo(f)
    end
  end
  
  private
  
  def import_photo(f)
    photo = Photo.from_file(f)
    if photo.save
      say "imported photo##{photo.id} from #{f}"
      FileUtils.move(f, archive_dir) if archive_dir
    else
      say "import of #{f} failed:"
      photo.errors.to_a.each do |msg|
        say "  - #{msg}"
      end
    end
  end

end

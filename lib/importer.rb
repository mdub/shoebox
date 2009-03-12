class Importer

  attr_writer :out
  
  def out
    @out || $stdout
  end

  def say(message)
    out.puts(message)
  end
  
  def import(filenames)
    filenames.each do |f|
      photo = Photo.from_file(f)
      if photo.save
        say "imported photo##{photo.id} from #{f}"
      else
        say "import of #{f} failed:"
        photo.errors.to_a.each do |msg|
          say "  - #{msg}"
        end
      end
    end
  end
  
end

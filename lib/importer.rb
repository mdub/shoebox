require "pathname"

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
    Import.of_files(filenames).execute do |f|
      relative_path = Pathname(f.path).expand_path.relative_path_from(Pathname.pwd)
      if f.succeeded?
        say "imported photo##{f.photo.id} from #{relative_path}"
        FileUtils.move(f.path, archive_dir) if archive_dir
      else
        say "import of #{relative_path} failed:"
        f.messages.each do |msg|
          say "  - #{msg}"
        end
      end
    end
  end

end

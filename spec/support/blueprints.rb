require "machinist/active_record"
require "faker"

Import.blueprint do
end

ImportFile.blueprint do
  import { Import.make }
  path { "/a/b/c.jpg" }
end

Photo.blueprint do
  image { File.new(image_fixture_file("ngara.jpg")) }
end
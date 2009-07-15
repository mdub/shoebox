require "machinist"
require "faker"

Import.blueprint do
end

ImportFile.blueprint do
  import { Import.make }
  path { "/a/b/c.jpg" }
end

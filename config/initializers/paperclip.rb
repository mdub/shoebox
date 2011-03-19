Paperclip.interpolates(:attachment_fu_id) do |upload, style|
  File.join(("%08d" % upload.instance.id).scan(/..../))
end

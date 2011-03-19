Paperclip.interpolates(:attachment_fu_id) do |upload, style|
  unless upload.instance.id
    raise("no id for #{upload.instance.inspect}") 
  end
  File.join(("%08d" % upload.instance.id).scan(/..../))
end

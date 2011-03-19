Paperclip::Attachment.interpolations[:attachment_fu_id] = proc do |upload, style|
  File.join(("%08d" % upload.instance.id).scan(/..../))
end

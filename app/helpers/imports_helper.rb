# encoding: UTF-8

module ImportsHelper

  PENDING = "◦"
  DONE = "●"
  FAILED = "✘"

  def import_file_status(import)
    if import.complete?
      if import.failed?
        content_tag(:span, FAILED, :class => "problematic")
      else
        content_tag(:span, DONE, :class => "okay")
      end
    else
      PENDING
    end
  end

end

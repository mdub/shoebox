module NavigationHelper
  
  def nav_link(label, path)
    options = {}
    options[:class] = "current" if prefix_of_current_page?(path)
    link_to(label, path, options)
  end
  
  private

  def prefix_of_current_page?(url)
    url = url_for(url)
    request.request_uri.starts_with?(url)
  end
  
end

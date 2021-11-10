module ApplicationHelper

  # for returning the full page title
  def full_title(page_title = '')
    base_title = "Mars Rover App"
    return page_title.empty? ? base_title : (page_title + " | " + base_title)
  end

end

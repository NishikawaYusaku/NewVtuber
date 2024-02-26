module ApplicationHelper
  def page_title(title)
    base_title = 'NewVtuber'
    title.empty? ? base_title : title + " - " + base_title
  end
end

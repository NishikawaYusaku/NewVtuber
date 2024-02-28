module ApplicationHelper
  def page_title(title)
    base_title = 'にゅーぶい！'
    title.empty? ? base_title : title + " - " + base_title
  end
end

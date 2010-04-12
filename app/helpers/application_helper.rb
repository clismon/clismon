# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(label)
    content_for(:title) {label}
    "<h1>#{label}</h1>"
  end
end

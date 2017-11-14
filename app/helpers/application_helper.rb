module ApplicationHelper

  def link_to_active?(body, url, html_options = {})
    active = "active" if current_page?(url)
    link_to body, url, html_options.merge!(class: "#{active}") { | key, v1, v2 | "#{v1} #{v2}" }
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end 
end

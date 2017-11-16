module ApplicationHelper

  def active_link_to(body, url, html_options = {})
    active = "active" if current_page?(url)
    link_to body, url, html_options.merge!(class: "#{active}") { | key, v1, v2 | "#{v1} #{v2}" }
  end

  def link_to_category(body, cat, html_options = {})
    if defined?(controller.namespace) 
      active = "active" if cat.to_s == controller.namespace
    else
      active = "active" if cat.to_s == controller_name
    end
    link_to body, "#", html_options.merge!(class: "#{active}", 
                                           'data-toggle': "dropdown", 
                                           'aria-haspopup': "true", 
                                           'aria-expanded': "false",
                                          ) { | key, v1, v2 | "#{v1} #{v2}" }
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

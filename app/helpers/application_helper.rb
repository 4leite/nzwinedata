module ApplicationHelper

  def active_link_to(body, url, html_options = {})
    active = "active" if current_page?(url)
    link_to body, url, html_options.merge!(class: "#{active}") { | key, v1, v2 | "#{v1} #{v2}" }
  end

  def bold_active_link_to(body, url, html_options = {})
    active = "active font-weight-bold" if current_page?(url)
    link_to body, url, html_options.merge!(class: "#{active}") { | key, v1, v2 | "#{v1} #{v2}" }
  end

  def submit_button_name
    case action_name
    when 'index', 'new', 'create'
      "Insert"
    when :edit
      "Update"
    else
      "Submit"
    end
  end

  def link_to_category(obj, url, cat, html_options = {})
    if defined?(controller.namespace) 
      active = "active" if cat.to_s == controller.namespace
    else
      active = "active" if cat.to_s == controller_name
    end
    link_to obj, url, html_options.merge!(class: "#{active}") { | key, v1, v2 | "#{v1} #{v2}" }
  end

  def decimal_aligned_money(money)
    if money_without_cents(money) == humanized_money(money)
      "#{money_without_cents(money)}<span class= 'invisible'>.00</span>".html_safe
    else
      humanized_money(money)
    end
  end

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def sortable_link_to(column, obj, title: nil)
    title = title || column.titleize
    css_class = column == sort_column ? sort_order : nil
    direction = column == sort_column && sort_order == "asc" ? "desc" : "asc"
    
    if css_class == "asc"
      header_class = "chevron-circle-up"
    elsif css_class == "desc"
      header_class = "chevron-circle-down"
    end
    
    link_to(url_for(controller: :daily_sales, sort: column, direction: direction, page: page) ) do
      title.html_safe + 
      content_tag(:span, "", class: "fa fa-#{header_class}")
    end
  end 
end

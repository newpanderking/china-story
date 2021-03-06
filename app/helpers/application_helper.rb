# coding: utf-8
module ApplicationHelper
  def alert_message message, type = 'alert-error'
    return '' if message.blank?

    html = <<-HTML
      <div class="alert alert-block #{type}">
        <a href="#" class="close" data-dismiss="alert">x</a>
        #{message}
      </div>
    HTML

    html.html_safe
  end

  def dynasty_menu
    dynasties = YAML.load_file 'data/dynasty_menu.yml'

    dynasties.map do |dynasty|
      style_class = ''
      if dynasty['controller'] != 'home' and
        controller_name == dynasty['controller'] and
        action_name == dynasty['action']
        style_class = 'active'
      end

      content_tag :li, link_to(dynasty['title'],
          :controller => "/#{dynasty['controller']}",
          :action => dynasty['action']
        ),:class => style_class
    end.join.html_safe
  end

  def menu menu_name, menu_id, menu_items
    menu_items = menu_items.map do |menu_item|
      content_tag :li, menu_item
    end.join

    html = <<-HTML
      <li class="dropdown" id="#{menu_id}">
        <a href="#{'#' + menu_id}" class="dropdown-toggle" data-toggle="dropdown">
          #{menu_name}
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">#{menu_items}</ul>
      </li>
    HTML

    html.html_safe
  end
end

# encoding: utf-8

module ApplicationHelper

  include StaffsHelper # for topnav to use nickname

  def count_as_zheng(count)
    i = count.to_i
    i == 0 ? '〇' : '正' * (i / 5) + ['', *'丨丄上止正'.chars][i % 5]
  end

  def subnav(param, tags, url, default = nil)
    selected = (params[param] || default.to_s).downcase.split(',')

    if not url.include?('?')
      url << '?'
    else
      url << '&'
    end

    dd_list = tags.map{|s| s.to_s}.map do |tag|
      "<dd#{selected.include?(tag.downcase) ? ' class="active"' : ''}>" +
        link_to(tag, params.merge(param => tag.downcase)) +
      "</dd>"
    end

    "<dl class='sub-nav'><dt>#{param.to_s.capitalize}:</dt>#{dd_list.join('&nbsp;')}</dl>".html_safe
  end

  def ti(time)
    time.localtime.strftime('%y-%m-%d %H:%M')
  end

  def integer_select(form, field, list, *options)
    form.select field, options_for_select(list.map.with_index.to_a), *options
  end

end

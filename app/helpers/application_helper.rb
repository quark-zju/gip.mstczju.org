# encoding: utf-8

module ApplicationHelper
  def markup(content, filename='topic.markdown')
    GitHub::Markup.render(filename, content)
  end

  def count_as_zheng(count)
    i = count.to_i
    i == 0 ? '〇' : '正' * (i / 5) + ['', *'丨丄上止正'.chars][i]
  end
end

module TopicsHelper

  include StaffsHelper

  def state_labels_of(topic)
    topic.state.map do |st|
      classes = [:round, :label]
      text = st.to_s

      if st == :closed
        classes << :alert
        text.capitalize!
      else
        text.upcase!
      end

      "<span class='#{classes.join(' ')}'>#{text}</span>"
    end.join('&nbsp;').html_safe
  end

  def content_html_of(topic)
    filename = case topic.text_filter
               when 0
                 'topic.md'
               when 1
                 'topic.textile'
               end
    GitHub::Markup.render(filename, topic.content)
  end

end

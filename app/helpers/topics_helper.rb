# coding: utf-8

module TopicsHelper

  include StaffsHelper

  def state_labels_of(topic)
    topic.state.map do |st|
      classes = [:round, :label]
      text = st.to_s.capitalize

      if st == :closed
        classes << :alert
      elsif text.length < 4
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

  def content_preview_of(topic)
    cached = topic.content_preview.presence
    if cached.present?
      cached
    else
      # calc content preview on demand
      preview = sanitize(content_html_of(topic), tags: '').truncate(400).gsub(/\s+/, ' ')
      topic.update_column :content_preview, preview
      preview
    end.html_safe
  end

  def toggle_button_of(topic, people, verb = nil)
    verb ||= people.to_s.sub(/ers$/, '').capitalize
    html = if topic.send(people).include?(current_staff)
             link_to "☑  #{verb}", register_topic_path(topic, :do => "#{people}_delete"), :method => :post, :class => [:button]
           else
             link_to "☐  #{verb}", register_topic_path(topic, :do => "#{people}_push"), :method => :post, :class => [:button, :secondary]
           end
    "<li>#{html}</li>".html_safe
  end
end

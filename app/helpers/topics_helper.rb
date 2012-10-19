module TopicsHelper

  def state_labels_for(topic)
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

end

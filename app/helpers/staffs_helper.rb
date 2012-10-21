module StaffsHelper

  def nickname_of(staff, format = :short)
    case format
    when :long, :medium
      medium = if staff.nick.present?
                 "#{staff.nick} (#{staff.name})"
               else
                 staff.name
               end 
      format == :long ? medium + " <#{staff.email}>" : medium
    when :name
      staff.name
    when :short
      staff.nick.presence || staff.name
    else
      raise RuntimeError.new("Unknown nickname format: #{format}")
    end
  end

  def avatar_of(staffs, style = :avatar_only, options = {})
    has_name = style.to_s.include? 'name'
    has_avatar = style.to_s.include? 'avatar'
    is_list = style.to_s.include? 'list'

    image_options = options.merge(class: ['avatar-icon', *options[:class]])
    image_options[:class] << ['has-tip', 'noradius', 'tip-normal', 'tip-top'] unless has_name

    result = [*staffs].map do |staff|
      tip = html_escape(nickname_of(staff, :long))

      if has_name
        avatar = image_tag staff.avatar.url(:icon), image_options
        name = "<span#{is_list ? '' : " title='#{tip}'"}>#{html_escape nickname_of(staff)}</span>"
      else
        avatar = image_tag staff.avatar.url(:icon), image_options.merge(title: tip)
      end

      case style
      when :avatar_only
        avatar
      when :name_and_avatar
        [name, avatar].join
      when :avatar_and_name
        [avatar, name].join
      when :avatar_and_name_list
        ["<li title=\"#{tip}\">", avatar, name, '</li>'].join
      end
    end

    case style
    when :avatar_and_name_list
      ['<ul class="no-bullet">', *result, '</ul>'].join
    else
      result.join
    end.html_safe
  end

end

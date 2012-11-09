module ApplicationHelper
  def skill_badge(skill, domain)
    all = skill.users.to_a.select {|u| u.domain == domain }
    present = all.select {|u| u.status == :office }
    present_count = present.count
    total = all.count
    colour = case present_count
             when 0
               'important'
             when 1
               'warning'
             else
               'success'
             end
    content_tag :span, class: "badge badge-#{colour} h3" do
      "#{skill.name} #{present.count}/#{all.count}"
    end
  end

  def status_badge(user)
    colour = case user.status
             when :home
               'default'
             when :office
               'success'
             when :break
               'warning'
             else
               'inverted'
             end
    content_tag :span, class: "badge badge-#{colour}" do
      if user.status == :break
        "Be back in #{distance_of_time_in_words(Time.now, user.away_until)}"
      elsif user.status == :office
        "Here for #{distance_of_time_in_words(Time.now, user.present_until)}"
      else
        user.status.to_s.titleize
      end
    end
  end

  def complex_button(object, label, data)
    form_for(object, html: {class: 'force-inline'}) do |f|
      fields = data.map { |col, val| f.hidden_field col, value: val }
      fields << f.button(label, class: 'btn btn-mini btn-primary')
      fields.join.html_safe
    end
  end

  def status_update_buttons(user)
    case user.status
    when :away
      [ complex_button(user, "I'm here!",
                       present_until: Time.now + 8.hours) ]
    when :office
      [
        complex_button(user, "I'm outta here!",
                       present_until: 1.second.ago),
        complex_button(user, "Be back in an hour!",
                       away_until: Time.now + 1.hour),
        complex_button(user, "Be back in 15!",
                       away_until: Time.now + 15.minutes)
      ]
    when :break
      [
        complex_button(user, "I'm back early!",
                       away_until: 1.second.ago),
        complex_button(user, "Gonna be another 30..",
                       away_until: user.away_until + 30.minutes),
        complex_button(user, "I'm outta here!",
                       present_until: 1.second.ago)
      ]
    else
      [ complex_button(user, "I'm here!",
                       present_until: Time.now + 8.hours) ]
    end
  end

end

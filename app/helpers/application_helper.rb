module ApplicationHelper
  def skill_badge(skill, domain)
    all = skill.users.in_domain(domain)
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
    content_tag :span, class: "badge badge-#{colour}" do
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
      else
        user.status.to_s.titleize
      end
    end
  end
end

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :skills, :domain,
                  :present_until, :away_until
  has_and_belongs_to_many :skills

  scope :in_domain, ->(domain) { where domain: domain }
  scope :and_skills, ->() { includes(:skills) }

  def present?
    present_until && present_until > Time.now
  end

  def away?
    away_until && away_until > Time.now
  end

  def status
    if present?
      if away?
        :break
      else
        :office
      end
    else
      :home
    end
  end

  def skills_list
    skills.map(&:name).join(', ')
  end

  def skills_list=(list)
    list = list.split(',').map(&:strip)
    new_skills = list.map {|s| Skill.where(name: s).first_or_create!}
    self.skills = new_skills
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.domain = user.email.split('@').last
      end
    end
  end

end

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email
  has_and_belongs_to_many :skills

  scope :in_domain, ->(domain) { where domain: domain }

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

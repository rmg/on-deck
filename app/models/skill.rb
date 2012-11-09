class Skill < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users

  scope :in_domain, ->(domain) {
    joins(:users).where(users: {domain: domain}).uniq
  }
end

class Domain < ActiveRecord::Base
  has_many :domain_patterns
  has_many :patterns, through: :domain_patterns

  validates :domain, uniqueness: true
end

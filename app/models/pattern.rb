class Pattern < ActiveRecord::Base
  has_many :domain_patterns
  has_many :domains, through: :domain_patterns

  validates :pattern, uniqueness: true
end

class DomainPattern < ActiveRecord::Base
  belongs_to :domain
  belongs_to :pattern

  def self.format_emails(first_name, last_name, domain)
    patterns = patterns(domain)
    patterns.each do |pattern|
      pattern.gsub!('first_name', first_name)
      pattern.gsub!('first_initial', first_name[0])
      pattern.gsub!('last_name', last_name)
      pattern.gsub!('last_initial', last_name[0])
    end
  end

  def self.patterns(domain)
    Domain.find_by(domain: domain).patterns.pluck(:pattern)
  end
end

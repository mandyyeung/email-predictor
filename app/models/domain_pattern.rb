class DomainPattern < ActiveRecord::Base
  belongs_to :domain
  belongs_to :pattern

  def self.format_emails(first_name, last_name, domain)
    emails = format_names(first_name, last_name, domain)
    if emails.first == 'No email match found!'
      emails
    else
      emails.inject([]) do |results, pattern|
        results << pattern + '@' + domain
        results
      end
    end
  end

  def self.format_names(first_name, last_name, domain)
    if Domain.pluck(:domain).include?(domain)
      patterns = patterns(domain)
      patterns.each do |pattern|
        pattern.gsub!('first_name', first_name)
        pattern.gsub!('first_initial', first_name[0])
        pattern.gsub!('last_name', last_name)
        pattern.gsub!('last_initial', last_name[0])
      end
    else
      ['No email match found!']
    end
  end

  def self.patterns(domain)
    Domain.find_by(domain: domain).patterns.pluck(:pattern)
  end
end

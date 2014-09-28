require 'net/http'

class DomainPattern < ActiveRecord::Base
  belongs_to :domain
  belongs_to :pattern

  def self.working_emails(first_name, last_name, domain)
    emails = format_emails(first_name, last_name, domain)
    emails.delete_if do |email|
      verify_email(email)
    end
    emails.empty? ? ['No email matches found!'] : emails
  end

  def self.verify_email(email)
    uri = URI("http://api.verify-email.org/api.php?usr=nectarflowers&pwd=testing1&check=#{email}")
    response_body = Net::HTTP.get(uri)
    response_body.include?('does not exist')
  end

  def self.format_emails(first_name, last_name, domain)
    emails = format_names(first_name, last_name, domain)
    emails.inject([]) do |results, name|
      results << name + '@' + domain
      results
    end
    # returns an array of results, ex. ["mandy.y@google.com", "m.yeung@google.com"]
  end

  def self.format_names(first_name, last_name, domain)
    if Domain.pluck(:domain).include?(domain)
      patterns = patterns(domain)
    else
      patterns = Pattern.pluck(:pattern)
    end
    construct_names(first_name, last_name, patterns)
    # returns an array of formatted names, ex. ["mandy.y", "m.yeung"]
  end

  def self.construct_names(first_name, last_name, patterns)
    patterns.each do |pattern|
      pattern.gsub!('first_name', first_name)
      pattern.gsub!('first_initial', first_name[0])
      pattern.gsub!('last_name', last_name)
      pattern.gsub!('last_initial', last_name[0])
    end
    # returns an array of formatted names, ex. ["mandy.y", "m.yeung"]
  end

  def self.patterns(domain)
    Domain.find_by(domain: domain).patterns.pluck(:pattern)
    # returns array of patterns ex. ["first_name.last_initial", "first_initial.last_name"]
  end
end

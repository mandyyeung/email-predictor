require_relative 'interpret_data'

class EmailAnalyzer
  def initialize(name, domain)
    @name = name
    @domain = domain
    @patterns = InterpretData.new.uniq_patterns
  end

  def match_names
    names = []
    domain_patterns.each do |pattern|
      names << case
               when pattern == 'first_name_dot_last_name'
                 "#{first_name}.#{last_name}"
               when pattern == 'first_name_dot_last_initial'
                 "#{first_name}.#{last_initial}"
               when pattern == 'first_initial_dot_last_name'
                 "#{first_initial}.#{last_name}"
               when pattern == 'first_initial_dot_last_initial'
                 "#{first_initial}.#{last_initial}"
               else
                 nil
               end
    end
    names
  end

  def construct_emails
    match_names.compact.map do |name|
      name + '@' + @domain
    end
  end

  private

  def domain_patterns
    @patterns[@domain] || []
  end

  def first_name
    @name.downcase.split(' ')[0]
  end

  def last_name
    @name.downcase.split(' ')[1]
  end

  def first_initial
    first_name[0]
  end

  def last_initial
    last_name[0]
  end

end

p EmailAnalyzer.new("Barack Obama", "whitehouse.gov").construct_emails

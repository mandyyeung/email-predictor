class DomainPatternsController < ActionController::Base
  def index
  end

  def new
    @domain_pattern = DomainPattern.new
  end

  def show
    @first_name, @last_name = params[:name].downcase.split
    @domain = params[:domain]
    @patterns = DomainPattern.format_emails(@first_name, @last_name, @domain)
    @emails = @patterns.inject([]) do |results, pattern|
      results << pattern + '@' + @domain
      results
    end
  end
end

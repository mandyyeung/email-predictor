class DomainPatternsController < ActionController::Base
  def index
  end

  def new
    @domain_pattern = DomainPattern.new
  end

  def show
    @first_name, @last_name = params[:name].downcase.split
    @domain = params[:domain]
    @emails = DomainPattern.validate_emails(@first_name, @last_name, @domain)
  end
end

class DomainPatternsController < ApplicationController
  def show
    @first_name, @last_name = params[:name].downcase.split
    @domain = params[:domain]
    @emails = DomainPattern.format_emails(@first_name, @last_name, @domain)
  end
end

require 'spec_helper'

describe 'DomainPattern' do
  let(:domain) { Domain.create(domain: 'alphasights.com') }
  let(:pattern) { Pattern.create(pattern: 'first_name.last_name') }
  let(:association) { domain.patterns << pattern }
  let(:test_domain_1) { 'alphasights.com' }
  let(:test_domain_2) { 'abc.com' }
  let(:test_pattern_1) { 'first_name.last_name' }
  let(:first_name) { 'john' }
  let(:last_name) { 'ferguson' }

  it 'associates patterns for the domain' do
    expect(association).to include(pattern)
  end

  context '#patterns' do
    it 'can identify patterns associated to a domain' do
      patterns = DomainPattern.patterns(test_domain_1)
      expect(patterns).to include(test_pattern_1)
    end
  end

  context '#format_names' do
    it 'formats names properly based on known patterns' do
      formats = DomainPattern.format_names(first_name, last_name, test_domain_1)
      expect(formats).to include('john.ferguson')
    end

    it 'returns an error message if domain is not in the database' do
      formats = DomainPattern.format_names(first_name, last_name, test_domain_2)
      expect(formats).to eq(['No email match found!'])
    end
  end

  context '#format_emails' do
    it 'formats emails properly based on known patterns' do
      formats = DomainPattern.format_emails(first_name, last_name, test_domain_1)
      expect(formats.first).to eq('john.ferguson@alphasights.com')
    end

    it 'returns an error message if domain is not in the database' do
      formats = DomainPattern.format_names(first_name, last_name, test_domain_2)
      expect(formats.first).to eq('No email match found!')
    end
  end
end

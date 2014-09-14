require 'spec_helper'

describe 'DomainPattern' do
  let(:domain) { Domain.find_by(domain: 'alphasights.com') }
  let(:pattern) { Pattern.find_by(pattern: 'first_name.last_name') }
  let(:test_domain_1) { 'alphasights.com' }
  let(:test_domain_2) { 'whitehouse.gov' }
  let(:test_pattern_1) { 'first_name.last_name' }
  let(:first_name) { 'john' }
  let(:last_name) { 'ferguson' }

  it 'associates patterns for the domain' do
    expect(domain.patterns).to include(pattern)
  end

  context '#patterns' do
    it 'can identify patterns associated to a domain' do
      patterns = DomainPattern.patterns(test_domain_1)
      expect(patterns).to include(test_pattern_1)
    end
  end

  context '#construct_names' do
    it 'formats names properly based on known patterns' do
      formats = DomainPattern.construct_names(first_name, last_name, [test_pattern_1])
      expect(formats).to include('john.ferguson')
    end
  end

  context '#format_names' do
    it 'formats names properly based on company domain' do
      formats = DomainPattern.format_names(first_name, last_name, test_domain_1)
      expect(formats).to include('john.ferguson')
    end

    it 'returns an error message if domain is not in the database' do
      formats = DomainPattern.format_names(first_name, last_name, test_domain_2)
      expect(formats).to eq([])
    end
  end

  context '#format_emails' do
    it 'formats emails properly based on known patterns' do
      formats = DomainPattern.format_emails(first_name, last_name, test_domain_1)
      expect(formats.first).to eq('john.ferguson@alphasights.com')
    end

    it 'returns an error message if domain is not in the database' do
      formats = DomainPattern.format_emails(first_name, last_name, test_domain_2)
      expect(formats).to eq(['No email match found!'])
    end
  end
end

require 'spec_helper'

describe 'Domain' do
  let(:domain) { Domain.new }
  let(:pattern) { Pattern.new }

  it 'has many patterns' do
    domain.patterns << pattern
    expect(domain.patterns).to include(pattern)
  end

  it 'has only saves a domain once' do
    domain.domain = 'alphasights.com'
    Domain.create(domain: 'alphasights.com')
    expect(Domain.all.count).to eq(1)
  end
end

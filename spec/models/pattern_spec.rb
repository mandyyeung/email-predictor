require 'spec_helper'

describe 'Pattern' do
  let(:domain) { Domain.new }
  let(:pattern) { Pattern.new }

  it 'has many domains' do
    pattern.domains << domain
    expect(pattern.domains).to include(domain)
  end

  it 'has only saves a pattern once' do
    pattern.pattern = 'first_name.last_name'
    Pattern.create(pattern: 'first_name.last_name')
    expect(Pattern.all.count).to eq(1)
  end
end

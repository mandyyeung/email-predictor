require 'spec_helper'

describe 'predicting emails', :type => :feature do

  it 'will report no matches if domain is not in database' do
    visit '/'
    fill_in('name', :with => 'Barack Obama')
    fill_in('domain', :with => 'whitehouse.gov')
    click_button('Submit')
    expect(page).to have_content('No email match found!')
  end
end

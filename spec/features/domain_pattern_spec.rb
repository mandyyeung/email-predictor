require 'spec_helper'

describe 'predicting emails', type: :feature do

  context 'alphasights.com' do
    it 'will predict the correct email address' do
      visit '/'
      fill_in('name', with: 'Peter Wong')
      fill_in('domain', with: 'alphasights.com')
      click_button('Submit')
      expect(page).to have_content('peter.wong@alphasights.com')
    end

    it 'will not predict false email addresses' do
      visit '/'
      fill_in('name', with: 'Peter Wong')
      fill_in('domain', with: 'alphasights.com')
      click_button('Submit')
      expect(page).to_not have_content('peter.w@alphasights.com')
    end
  end

  context 'google.com' do
    it 'will predict the correct email address' do
      visit '/'
      fill_in('name', with: 'Craig Silverstein')
      fill_in('domain', with: 'google.com')
      click_button('Submit')
      expect(page).to have_content('craig.s@google.com c.silverstein@google.com')
    end

    it 'will not predict false email addresses' do
      visit '/'
      fill_in('name', with: 'Craig Silverstein')
      fill_in('domain', with: 'google.com')
      click_button('Submit')
      expect(page).to_not have_content('craig.silverstein@google.com')
    end
  end

  context 'apple.com' do
    it 'will predict the correct email address' do
      visit '/'
      fill_in('name', with: 'Steve Wozniak')
      fill_in('domain', with: 'apple.com')
      click_button('Submit')
      expect(page).to have_content('s.w@apple.com')
    end

    it 'will not predict false email addresses' do
      visit '/'
      fill_in('name', with: 'Steve Wozniak')
      fill_in('domain', with: 'apple.com')
      click_button('Submit')
      expect(page).to_not have_content('s.wozniak@apple.com')
    end
  end

  context 'other domains' do
    it 'will report no matches if domain is not in database' do
      visit '/'
      fill_in('name', with: 'Barack Obama')
      fill_in('domain', with: 'whitehouse.gov')
      click_button('Submit')
      expect(page).to have_content('No email match found!')
    end
  end
end

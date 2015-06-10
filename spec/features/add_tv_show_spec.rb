require "spec_helper"
require 'pry'

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do

    visit '/television_shows/new'
    fill_in 'title', with: "Married... with Children"
    fill_in 'network', with: 'Fox'
    fill_in 'starting_year', with: 1987
    fill_in 'ending_year', with: 1997
    select "Comedy", from: "genre"
    fill_in 'synopsis', with: 'A show about people'
    click_button 'Add TV Show'

    expect(page).to have_content("TV Shows")
    expect(page).to have_content("Married... with Children")
  end

  scenario "fail to add a show with invalid information" do

    visit '/television_shows/new'
    fill_in 'title', with: "Married... with Children"
    fill_in 'network', with: 'Fox'
    fill_in 'ending_year', with: 1997
    select "Comedy", from: "genre"
    fill_in 'synopsis', with: 'A show about people'
    click_button 'Add TV Show'

    TelevisionShow.new.save

    TelevisionShow.new.errors.full_messages

    # save_and_open_page

    expect(page).to have_content('Add Show')
    expect(page).to have_content("Error!")



  end
end

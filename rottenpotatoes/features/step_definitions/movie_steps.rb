# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # debugger
    Movie.create!(movie)
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: "(.*)"/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  ratings_arr = rating_list.split
  ratings_arr.each do |rating|
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  # fail "Unimplemented"
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  

  unless (page.all(:css, 'table tr').size==11)
    fail "Number of movies doesn't match"
  end
  # fail "Unimplemented"
end

Then /I should (not )?see movies only of following ratings: "(.*)"/ do |no,rating_list|

  ratings_arr = rating_list.split
  map = ratings_arr.map{ |rating| [rating, 1] }.to_h
  custom_path = "//table[@id='movies']/tbody//td[2]"
  page.all(:xpath, custom_path).each do |element|
    if !no && !map.key?(element.text)
      fail "Not filtered properly"
    elsif no && map.key?(element.text)
      fail "Not filtered properly"
    end
  end
end
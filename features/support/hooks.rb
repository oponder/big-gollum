After do |scenario|
  if scenario.passed?
    visit root_path
    ["apple", "pear"].each do |wiki|
      id = "delete_wiki-#{wiki}"
      unless first(:css, "##{id}").nil?
        click_on "#{id}"
      end
    end
  end
end
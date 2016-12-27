Feature: In order to do pretty much anything on the site
         I want to require users to be logged in

Scenario: Arriving at the site without being logged in, and no other accounts exist yet
    When I visit Big Gollum
    Then I should see "Big Gollum Please create an account"

Scenario: Arriving at the site without being logged in, and at least one account exists.
    Given a user account exists
    When I visit Big Gollum
    Then I should see "Log in"

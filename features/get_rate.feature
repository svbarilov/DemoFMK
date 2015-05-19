@get_rate
Feature: As a user I would like to get my custom loan rate quickly

  User should be able to get custom loan rates quickly after submitting personal information


  Scenario: User is directed to Get Custom Rate page after submitting basic loan information
    Given I launch my device with Prosper home page
    And I set "10000" as loan amount needed
    And I select "Auto" as loan purpose
    And I select "Good Credit" as credit score
    And I click on "check your rate" button on "home screen"
    Then I expect to be on get custom rate screen


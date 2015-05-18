@login
Feature: Login functionality

  Scenario Outline: Error message shown when user using incorrect credentials
    Given I launch my device with Distil Networks page
    And I press on expand menu button
    Then I press on Signin button
    And I type email "<login>" on login page
    And T type password "<password>" on login page
    When I press on SignIn on login page
    Then I expect to see error "Invalid credentials.1"
  Examples:
    | login               | password |
    | notexists@aaa.com   | qweqwe   |
    | 111                 | 222      |
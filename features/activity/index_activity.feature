Feature: viewing activities
  Scenario: a director views the recent activities
    Given a Director is logged in
    And there have been some appointment activities
    When they view the appointment activities index
    Then they should see the recent appointment activities


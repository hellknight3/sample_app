Feature: viewing activities
  Scenario: a director views the recent activities
    Given a Director is logged in
    And there have been some appointment activities
    When they view the appointment activities index
    Then they should see the recent appointment activities

    @wip
  Scenario: an Admin views the recent activities
    Given an Admin is logged in
    When they visit the activities path
    Then they should get an error message

  Scenario: a Doctor views the recent activities
    Given a Doctor is logged in
    When they visit the activities path
    Then they should get an error message

  Scenario: a Patient view the recent activities
    Given a Patient is logged in
    When they visit the activities path
    Then they should get an error message


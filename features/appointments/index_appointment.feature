Feature: viewing all my appointments
  Scenario: A user views their open appointments
    Given a Doctor is logged in
    And they have 3 Open appointments
    When they view their Open appointments
    Then they should see their 3 Open appointments

  Scenario: A user views their closed appointments
    Given a Doctor is logged in
    And they have 3 Closed appointments
    When they view their Closed appointments
    Then they should see their 3 Closed appointments

  Scenario: A user views their closed appointments
    Given a Doctor is logged in
    And they have 3 Future appointments
    When they view their Future appointments
    Then they should see their 3 Future appointments

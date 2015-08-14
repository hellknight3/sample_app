Feature: creating a pool
  Scenario: an admin creates a pool
    Given an Admin is logged in
    And the admin visits the new pools path
    When they submit a valid pool
    Then a pool should be created
    And the admin should be in the pool
    And a log entry with action created pool should be generated 

  Scenario: an admin tries to create an invalid pool
    Given an Admin is logged in
    And the admin visits the new pools path
    When they submit an invalid pool
    Then they should be on the new pools page
    And they should receive an error message

  Scenario: a patient tries to create a pool
    Given a Patient is logged in
    When the patient visits the new pools path
    Then they should receive an error message
    And they should be on the pools index page
  Scenario: a doctor tries to create a pool
    Given a Doctor is logged in
    When the doctor visits the new pools path
    Then they should receive an error message
    And they should be on the pools index page


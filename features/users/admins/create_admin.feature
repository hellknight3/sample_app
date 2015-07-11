Feature: creating an admin
  Scenario: when an admin creates an admin
    Given an Admin is logged in
    When they visit the new admin path
    Then they should receive an error message
    And they should be on their profile page
    
  Scenario: when an doctor creates an admin
    Given an Doctor is logged in
    When they visit the new admin path
    Then they should receive an error message
    And they should be on their profile page

  Scenario: when an patient creates an admin
    Given an Patient is logged in
    When they visit the new admin path
    Then they should receive an error message
    And they should be on their profile page
    
  Scenario: when an Director creates an admin
    Given an Director is logged in
    And they visit the new admin path
    When they submit valid admin information 
    Then they should receive a success message
    And the admin should be created
    And they should be on the edit user page
    And a log entry with the action create admin should be generated

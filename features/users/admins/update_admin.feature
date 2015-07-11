Feature: updating a admin
  Scenario: an admin edits themselves
    Given an Admin is logged in
    And they edit themselves 
    When they submit valid changes for a admin
    Then the admin should be updated
    And a success message should be displayed
    And they should be on their home page
    And a log entry with the action update admin should be generated

  Scenario: an admin edits another admins personal information
    Given an Admin is logged in
    And an Admin exists
    When they try to edit another admin
    Then they should receive an error message
    And they should be on their profile page
    
  Scenario: a director edits an admin an admins personal information
    Given an Director is logged in
    And an Admin exists
    When they try to edit an admin
    Then they should receive an error message
    And they should be on their profile page

  Scenario: a doctor edits an admins personal information
    Given a Doctor is logged in
    And an Admin exists
    When they try to edit an admin
    Then they should receive an error message
    And they should be on their profile page

  Scenario: a patient edits an admin personal information
    Given a Patient is logged in
    And an Admin exists
    When they try to edit an admin
    Then they should receive an error message
    And they should be on their profile page

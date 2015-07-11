Feature: updating a director
  Scenario: a director edits themselves
    Given a Director is logged in
    And they edit themselves 
    When they submit valid changes for a director
    Then the director should be updated
    And a success message should be displayed
    And they should be on their home page
    And a log entry with the action update admin should be generated

  Scenario: a director edits another director
    Given a Director is logged in
    And a Director exists
    When they try to edit another director
    Then they should receive an error message
    And they should be on their profile page
    
  Scenario: an admin edits a director
    Given a Admin is logged in
    And a Director exists
    When they try to edit a director
    Then they should receive an error message
    And they should be on their profile page

  Scenario: a doctor edits a director
    Given a Doctor is logged in
    And a Director exists
    When they try to edit a director
    Then they should receive an error message
    And they should be on their profile page

  Scenario: a patient edits a director
    Given a Patient is logged in
    And a Director exists
    When they try to edit a director
    Then they should receive an error message
    And they should be on their profile page

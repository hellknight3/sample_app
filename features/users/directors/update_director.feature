Feature: updating a director
  Scenario: a director edits themselves
    Given a Director is logged in
    And they edit themselves 
    When they submit valid changes for a director
    Then the director should be updated
    And a success message should be displayed
    And they should be on their home page
    And a log entry with the action update admin should be generated

  Scenario Outline: only a director can edit themselves
    Given a <role> is logged in
    And a Director exists
    When they try to edit a director
    Then they should receive an error message
    And they should be on their profile page
    Examples:
      |role|
      |Director|
      |Admin|
      |Doctor|
      |Patient|
    

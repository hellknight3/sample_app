Feature: updating a admin
  Scenario: an admin edits themselves
    Given an Admin is logged in
    And they edit themselves 
    When they submit valid changes for a admin
    Then the admin should be updated
    And a success message should be displayed
    And they should be on their home page
    And a log entry with the action update admin should be generated

  Scenario Outline: only an admin should be able to edit their own information 
    Given an <role> is logged in
    And an Admin exists
    When they try to edit an admin
    Then they should receive an error message
    And they should be on their profile page
    Examples:
      |role|
      |Admin|
      |Patient|
      |Doctor|
      #|Director|


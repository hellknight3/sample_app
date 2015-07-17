Feature: creating an admin
   
  Scenario: when an Director creates an admin
    Given an Director is logged in
    And they visit the new admin path
    When they submit valid admin information 
    Then they should receive a success message
    And the admin should be created
    And they should be on the edit user page
    And a log entry with the action create admin should be generated

  Scenario Outline: when an user other than a director creates an admin
    Given an <role> is logged in
    When they visit the new admin path
    Then they should receive an error message
    And they should be on their profile page
    Examples:
      |role|
      |Admin|
      |Doctor|
      |Patient|
   

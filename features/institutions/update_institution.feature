Feature: when a user updates a institution
  Scenario: when a director updates an institution
    Given a Director is logged in
    And they have an institution
    And they visit the edit institutions page
    When they submit valid updated institution information
    Then the institution should be changed
    And they should receive a success message
    And a log entry with the action updated institution should be generated
    And they should be on the institutions show page

  Scenario Outline: when a user tries to edit an institution
    Given a <role> is logged in
    And they have an institution
    When they visit the edit institutions page
    Then they should get an error message
    And they should be on their home page
    Examples:
      |role|
      |Admin|
      |Doctor|
      |Patient|
    

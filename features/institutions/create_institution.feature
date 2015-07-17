Feature: creating a new institution
  Scenario: when a director creates an institution with valid information  
    Given a Director is logged in
    And they visit the new institution path
    When they submit valid institution information
    Then a institution should be created
    And a log entry with the action created institution should be generated
    And they should be on the institutions page
    And a success message should be displayed
    And the Director should be added to the institution

   Scenario: when a director creates an invalid institution 
    Given a Director is logged in
    And they visit the new institution path
    When they submit invalid institution information
    Then they should be on the new institutions page
    And an error message should be displayed
  
  #--------------access permissions-----------------
  Scenario Outline: only directors can create institutions 
    Given an <role> is logged in
    When they try to create a institution
    Then they should get an error message
    And they should be on their homepage
  Examples:
    |role|
    |Admin|
    |Doctor|
    |Patient|

  Scenario: some one needs to be logged in
    Given an institution  exists
    When they try to create a institution
    Then they should be on the signin page

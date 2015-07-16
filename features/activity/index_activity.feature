Feature: viewing user's activities
  Scenario Outline: a director views the recent activities of a user
    Given a <role> is logged in
    And the <role> <action>s a <modelsFactory>
    And the user logs out
    And a Director is logged in
    When they view the <role>'s activities
    Then they should see the recent activities
  Examples:
      |role|action|modelsFactory|
      |Doctor|create|appointment|
      |Admin|create|Doctor| 
      |Admin|create|Patient|
      |Director|create|Admin|
      |Doctor|view|appointment|
    
  #--------------access permissions-----------------
  Scenario Outline: only some roles have access to the activities page
    Given an <role> is logged in
    And a Patient exists 
    When they view a Patient's activities
    Then they should get an error message
    And they should be on their homepage
  Examples:
    |role|
    |Admin|
    |Doctor|
    |Patient|

  Scenario: some one needs to be logged in
    Given a Patient exists
    When they view a Patient's activities
    Then they should be on the signin page

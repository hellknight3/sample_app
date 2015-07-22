Feature: creating a way to give a unique message for each institutions main page
  Scenario: a Director creates a new message for the institution
    Given a Director is logged in
    And the director has an institution
    And they visit the institutions show page
    When they submit a valid message
    Then they should still be on the institutions show page
    And they should see the message displayed
    And they should receive a success message
    And a log entry with the action created institution message should be generated

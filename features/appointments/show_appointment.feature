Feature: view an appointment
  Scenario: a doctor views an appointment
    Given a Doctor is logged in
    And they have an appointment
    When they view the appointment
    Then they should see the appointments pools
    And they should see who is participating in the appointment
    And they should see the appointments properies

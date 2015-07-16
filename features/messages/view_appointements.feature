Feature: view appointment name scrubbing
  Scenario: doctor views appointement with multiple patients
    Given a Doctor is logged in
    And they have an appointment with multiple participants
    When they view the appointment messages
    Then they should see who is participating in the appointment

  Scenario: patient views appointment with multiple patients
    Given a Patient is logged in
    And they have an appointment with multiple participants
    When they view the appointment messages
    Then they should see the doctor who is participating 
    And they should not see the patients names who are participating

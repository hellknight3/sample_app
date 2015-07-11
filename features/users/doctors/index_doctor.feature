Feature: when a doctor views his patients
  Scenario: a doctor views an accepted patients
    Given a Doctor is logged in
    And a Patient exists
    And a doctor has a patient accepted
    When the doctor views their Accepted patients
    Then they should see his accepted patient

  Scenario: a doctor views his pending patients
    Given a Doctor is logged in
    And a Patient exists
    And a doctor has a patient pending
    When the doctor views their Pending patients
    Then they should see his pending patients

  Scenario: a doctor views his rejected patients
    Given a Doctor is logged in
    And a Patient exists
    And a doctor has a patient rejected
    When the doctor views their Rejected patients
    Then they should see his rejected patients 

  Scenario: a patient views a doctors patients
    Given a Patient is logged in
    And a Doctor exists
    When they view a doctors patients
    Then they should receive an error message
    And they should be on their profile page

  Scenario: an Admin views a doctors patients
    Given an Admin is logged in
    And a Doctor exists
    When they view a doctors patients
    Then they should receive an error message
    And they should be on their profile page

  Scenario: an Director views a doctors patients
    Given an Director is logged in
    And a Doctor exists
    When they view a doctors patients
    Then they should receive an error message
    And they should be on their profile page

  Scenario: a Doctor views another doctors patient
    Given a Doctor is logged in
    And a Doctor exists
    When they view a doctors patients
    Then they should receive an error message
    And they should be on their profile page


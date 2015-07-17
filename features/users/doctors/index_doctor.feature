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

  Scenario Outline: only the doctor should be able to view their patients statuses
    Given a <role> is logged in
    And a Doctor exists
    When they view a doctors patients
    Then they should receive an error message
    And they should be on their profile page
    Examples:
      |role|
      |Director|
      |Admin|
      |Doctor|
      |Patient|

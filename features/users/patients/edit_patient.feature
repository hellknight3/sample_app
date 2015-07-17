Feature: editting a patient
  Scenario: when an admin edits a patient
    Given an Admin is logged in
    And a Patient exist
    And the Admin has a pool
    When they edit a patient setting pool
    Then they should be able to add pools
    When they add a pool
    Then a log entry with the action add permission should be generated
    And they should be able to remove pools
    When they remove a pool
    Then they should be able to add pools
    And a log entry with the action remove permission should be generated

  Scenario: when an admin adds doctors to patient 
    Given an Admin is logged in
    And a Patient exists
    And a Doctor exists
    And the Admin has a pool
    And the doctor has the same pool
    And the patient has the same pool
    When they edit a patient setting doctor
    Then they should be able to add doctors
    When they add a doctor
    Then they should see it pending
    And a Patient is being logged
    And a log entry with the action add doctor should be generated
    #And they should be able to remove doctors #will be pending may want to add remove aswell

  Scenario: when a patient edits self
    Given a Patient is logged in
    And they edit themselves
    When the patient updates their profile
    Then the patient should be changed
    And they should receive a success message
    And a log entry with action update should be generated

  Scenario Outline: only admins and patients should be change patient information
    Given a <role> is logged in
    And a Patient exist
    When they edit a patient
    Then they should receive an error message
    And they should be on their profile page
    Examples:
      |role|
      |Director|
      |Doctor|
      |Patient|

Feature: viewing a doctor
  Scenario: when an admin views a doctor
    Given an Admin is logged in

  Scenario: when a doctor views another doctor
    Given a Doctor is logged in

  Scenario: when a patient views a doctor
    Given a Patient is logged in

  Scenario: when a director views a doctor
    Given a Director is logged in

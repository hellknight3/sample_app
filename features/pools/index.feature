Feature: viewing associated pools
  Scenario: an admin views his pools
    Given an Admin is logged in
    And they have 3 pools
    When they visit the Personal pools index
    Then they should see their 3 pools

  Scenario: an admin views all pools
    Given an Admin is logged in
    And there are 3 pools
    When they visit the Other pools index
    Then they should see 3 pools
    And they should not be able to edit
    
  Scenario: a patient views his pools
    Given a Patient is logged in
    And they have 3 pools
    When they visit the Personal pools index
    Then they should see their 3 pools
    
  Scenario: a doctor views his pools
    Given a Doctor is logged in
    And they have 3 pools
    When they visit the Personal pools index
    Then they should see their 3 pools

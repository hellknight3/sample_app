Feature: When users view an institution
  Scenario: when a director views an institution
    Given a Director is logged in
    And they have an institution
    And the institution has 3 pools
    When they visit the institutions show page
    Then they should see institutions name
    And they should see institutions pools
    And they should see a news bulletin

    
  

Feature: editing pools
  Scenario: a director tries to edit a pool
    Given an Director is logged in
    And they have 1 pool
    When they visit the edit pools path
    Then they should see...
    
    @wip
  Scenario: an admin edits a pool
    Given an Admin is logged in 
    And they have 1 pool
    And they visit the edit pools path
    When they submit valid updates to the pool
    Then the pool should be changed
    And a log entry of the changes should be generated
    And they should be on the pools index page

    
    
    

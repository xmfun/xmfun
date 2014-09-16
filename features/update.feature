Feature: Update
  As a xmfun user
  I can update xmfun to lastest version
  through CLI

  Scenario: Update xmfun
    When I run `xmfun update`
    Then the output should contain "Updating installed gems"
    And the exit status should be 0

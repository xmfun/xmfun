Feature: Version
  As a xmfun user
  I can check the version of xmfun

  Scenario: Get xmfun version
    When I run `xmfun version`
    Then the output should contain exactly:
    """
    0.0.5

    """

  Scenario: Get xmfun version alias 1
    When I run `xmfun --version`
    Then the output should contain exactly:
    """
    0.0.5

    """

  Scenario: Get xmfun version alias 2
    When I run `xmfun -v`
    Then the output should contain exactly:
    """
    0.0.5

    """

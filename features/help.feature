Feature: Help
  In order to know how to use xmfun
  As a CLI
  I want to be as objective as possible

  Scenario: Get main help message
    When I run `xmfun help`
    Then the output should contain exactly:
    """
    Usage: xmfun <command> [<args>]

      -v, --version       Print the version
      -h, --help          Print this help
      -p, --proxy         Set Proxy Server

    Common commands:
      download            Download the mp3 files given an arg of url
      proxy               Set Proxy Server
      update              Update xmfun to the newest version
      version             Print the version
      help                Print this help

    Example:
      xmfun download http://www.xiami.com/song/3378080

    More info:
      xmfun <command> -h

    """
  Scenario: Get main help message alias 1
    When I run `xmfun -h`
    Then the output should contain exactly:
    """
    Usage: xmfun <command> [<args>]

      -v, --version       Print the version
      -h, --help          Print this help
      -p, --proxy         Set Proxy Server

    Common commands:
      download            Download the mp3 files given an arg of url
      proxy               Set Proxy Server
      update              Update xmfun to the newest version
      version             Print the version
      help                Print this help

    Example:
      xmfun download http://www.xiami.com/song/3378080

    More info:
      xmfun <command> -h

    """

  Scenario: Get main help message alias 2
    When I run `xmfun --help`
    Then the output should contain exactly:
    """
    Usage: xmfun <command> [<args>]

      -v, --version       Print the version
      -h, --help          Print this help
      -p, --proxy         Set Proxy Server

    Common commands:
      download            Download the mp3 files given an arg of url
      proxy               Set Proxy Server
      update              Update xmfun to the newest version
      version             Print the version
      help                Print this help

    Example:
      xmfun download http://www.xiami.com/song/3378080

    More info:
      xmfun <command> -h

    """
  Scenario: Get download help message
    When I run `xmfun download -h`
    Then the output should contain exactly:
    """
    Usage:
      xmfun download URL
      xmfun download URL -d DESINATION_FOLDER

    Example:
      xmfun download http://www.xiami.com/song/3378080
      xmfun download http://www.xiami.com/song/3378080 -d pink

    """
  Scenario: Get proxy help message
    When I run `xmfun proxy -h`
    Then the output should contain exactly:
    """
    Usage:
      xmfun download URL proxy HTTP[S]_PROXY
      xmfun download URL -p HTTP[S]_PROXY
      xmfun download URL --proxy HTTP[S]_PROXY

    Example:
      xmfun download http://www.xiami.com/song/3378080 proxy "http://111.1.3.38:8000"
      xmfun download http://www.xiami.com/song/3378080 -p "http://111.1.3.38:8000"
      xmfun download http://www.xiami.com/song/3378080 --proxy "http://111.1.3.38:8000"

    """
  Scenario: Get main help message when passing invalid argument
    When I run `xmfun WAT?`
    Then the output should contain exactly:
    """
    """

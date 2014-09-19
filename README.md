# XMfun
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/ipmsteven/xmfun?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Gem
Version](https://badge.fury.io/rb/xmfun.svg)](http://badge.fury.io/rb/xmfun)
[![Build
Status](https://travis-ci.org/ipmsteven/xmfun.svg?branch=master)](https://travis-ci.org/ipmsteven/xmfun)
[![Code
Climate](https://codeclimate.com/github/ipmsteven/xmfun/badges/gpa.svg)](https://codeclimate.com/github/ipmsteven/xmfun)

Yet Another Xiami Music Downloader

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xmfun'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xmfun

## Usage

```
Usage: xmfun <command> [<args>]

  -v, --version       Print the version
  -h, --help          Print this help

Common commands:
  download            Download the mp3 files given an arg of url
  update              Update xmfun to the newest version
  version             Print the version
  help                Print this help

Example:
  xmfun download http://www.xiami.com/song/3378080

More info:
  xmfun <command> -h
```

## Contributing

1. Fork it ( https://github.com/ipmsteven/xmfun/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

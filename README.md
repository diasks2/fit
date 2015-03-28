# fit [![Build Status](https://travis-ci.org/tjwallace/fit.svg?branch=master)](https://travis-ci.org/tjwallace/fit)

A ruby gem for parsing [fit files](http://www.thisisant.com/pages/products/fit-sdk). It makes heavy use of the [bindata gem](http://bindata.rubyforge.org/).

It is published on RubyGems.org as [fit-parser](https://rubygems.org/gems/fit-parser).

## Example usage

```ruby
require 'fit'

# Step 1: Load a .fit file
fit_file = Fit.load_file('/path-to-your-file/your-file.fit')
# or
fit_file = Fit.load_file(ARGV[0])

# Array of hashes with each element representing one data point from your workout ordered from start to finish.
fit_file.all_records

# Total time of your workout, including resting time
# String in the format of "%H:%M:%S"
fit_file.activity_total_time
# => "1:01:58"


# Total active time of your workout
# String in the format of "%H:%M:%S"
fit_file.activity_total_active_time
# => "00:58:34"

```

## Supported files

This library has been tested with files coming from the following devices:
  - Garmin Swim
  - Garmin Edge 501J


Please let me know if you have any success with files coming from devices that are not listed here.

## Contributing to fit
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 Jeff Wallace. See LICENSE.txt for further details.

# Remoppy

Remoppy is [slappy](https://github.com/wakaba260/slappy) clone gem. (Slappy is simple and great slack bot for Ruby.)

Remoppy support to make Remotty bot.

Use the Remotty Web API.

## Quick Start

Bundle gem from Github

```
$ mkdir remoppy_sample
$ cd remoppy_sample
$ bundle init
$ echo "gem 'remoppy', path: '/Users/sansan_dan/.ghq/github.com/dany1468/slappy'" >> Gemfile
$ bundle install
```

Run Generator

```
$ bundle exec remoppy new
        exist   .
        create  remoppy-scripts
        create  lib
        create  remoppy-scripts/example.rb
        create  remoppy_config.rb
$ tree
.
├── Gemfile
├── Gemfile.lock
├── lib
├── remoppy-scripts
│   └── example.rb
└── remoppy_config.rb
```

Set token

```
$ export REMOTTY_TOKEN=xxxxxx
```

Write Code

```ruby
# remoppy-scripts/example.rb

hear '^hello, remoppy!' do |event|
  logger.info 'received message!'
  say 'hello!!', participation_id: event.participation
end
```

Remoppy start

```
$ bundle exec remoppy start
```

(Stop: Input Ctrl+c)

## Contributing

1. Fork it ( http://github.com/dany1468/remoppy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


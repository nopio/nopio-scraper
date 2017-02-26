# NopioScraper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/nopio_scraper`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nopio_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nopio_scraper

## Usage

This gem allows to sign in, sign up, invite a friend or like a page on Facebook.

Creating an account on Facebook:
```ruby
scraper = NopioScraper::Facebook.new('piotr.jaworski@nopio.com', 'your_password')
scraper.create_account(first_name: 'Piotr', last_name: 'Jaworski', sex: 'male', day: '1', month: 'Jan', year: '1993')
```

Loging to Facebook:
```ruby
scraper = NopioScraper::Facebook.new('piotr.jaworski@nopio.com', 'your_password')
scraper.login
```

Liking a page:
```ruby
scraper = NopioScraper::Facebook.new('piotr.jaworski@nopio.com', 'your_password')
scraper.like_page('nopio')
```

Invitng a friend:
```ruby
scraper = NopioScraper::Facebook.new('piotr.jaworski@nopio.com', 'your_password')
scraper.invite_friend('Piotr Jaworski')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nopio/nopio_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

